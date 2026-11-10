package com.tkheat.service;

import java.io.ByteArrayOutputStream;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import com.tkheat.dao.PayrollDao;
import com.tkheat.domain.PayrollEmp;
import com.tkheat.domain.PayrollMonth;
import com.tkheat.domain.PayrollSent;
import com.tkheat.domain.PayrollSet;
import com.tkheat.domain.PayrollSlip;

@Service
public class PayrollServiceImpl implements PayrollService {

	@Autowired
	private PayrollDao payrollDao;

	@Override
	public List<PayrollEmp> getEmpList() {
		return payrollDao.getEmpList();
	}

	@Override
	public void empSave(PayrollEmp emp) {
		if (payrollDao.empUpdate(emp) == 0) {
			payrollDao.empInsert(emp);
		}
	}

	@Override
	public List<PayrollMonth> getMonthList(String ym) {
		return payrollDao.getMonthList(ym);
	}

	@Override
	public void monthSave(PayrollMonth month) {
		if (payrollDao.monthUpdate(month) == 0) {
			payrollDao.monthInsert(month);
		}
	}

	@Override
	public void monthDelete(String ym, String worker_no) {
		payrollDao.monthDelete(ym, worker_no);
	}

	@Override
	public List<PayrollSent> getSentList(String ym) {
		return payrollDao.getSentList(ym);
	}

	@Override
	public void sentSave(PayrollSent sent) {
		if (payrollDao.sentUpdate(sent) == 0) {
			payrollDao.sentInsert(sent);
		}
	}

	@Override
	public PayrollSet getSet() {
		return payrollDao.getSet();
	}

	@Override
	public void setSave(PayrollSet set) {
		PayrollSet existing = payrollDao.getSet();
		if (existing == null) {
			payrollDao.setInsert(set);
		} else {
			set.setPst_idx(existing.getPst_idx());
			payrollDao.setUpdate(set);
		}
	}

	@Override
	public void sendMail(String to, String subject, PayrollSlip slip) throws Exception {
		PayrollSet set = payrollDao.getSet();
		if (set == null || set.getSmtpHost() == null || set.getSmtpHost().trim().isEmpty()) {
			throw new IllegalStateException("SMTP 서버 설정이 필요합니다. 설정 탭에서 SMTP 서버 정보를 먼저 입력하세요.");
		}
		final String smtpUser = set.getSmtpUser();
		final String smtpPass = set.getSmtpPass();
		// 네이버 등 일부 메일사는 SMTP 로그인 아이디로 전체 이메일이 아니라 "@" 앞부분만 받음
		final String host = set.getSmtpHost() != null ? set.getSmtpHost().toLowerCase() : "";
		final String loginUser = (host.contains("naver.com") && smtpUser != null && smtpUser.contains("@"))
				? smtpUser.substring(0, smtpUser.indexOf('@'))
				: smtpUser;

		int port = set.getSmtpPort() != null ? set.getSmtpPort() : 587;

		Properties props = new Properties();
		props.put("mail.smtp.host", set.getSmtpHost());
		props.put("mail.smtp.port", String.valueOf(port));
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.connectiontimeout", "10000");
		props.put("mail.smtp.timeout", "10000");
		if (port == 465) {
			props.put("mail.smtp.socketFactory.port", String.valueOf(port));
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");
		} else {
			props.put("mail.smtp.starttls.enable", "true");
		}

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(loginUser, smtpPass);
			}
		});

		// 어느 SMTP 명령 직후에 연결이 끊기는지 그대로 캡처해서, 실패 시 메시지에 포함시킨다.
		java.io.ByteArrayOutputStream debugOut = new java.io.ByteArrayOutputStream();
		session.setDebug(true);
		session.setDebugOut(new java.io.PrintStream(debugOut, true, "UTF-8"));

		// 보내는 사람 주소에 "@도메인"이 빠져 있으면(계정 아이디만 입력한 경우) SMTP 호스트에서 도메인을 추정해 붙여준다.
		// (예: smtpUser="th816", smtpHost="smtp.naver.com" -> "th816@naver.com")
		String fromAddr = smtpUser;
		if (fromAddr != null && !fromAddr.contains("@") && !host.isEmpty()) {
			String domainGuess = host.startsWith("smtp.") ? host.substring(5) : host;
			fromAddr = fromAddr + "@" + domainGuess;
		}
		final String fromAddrFinal = fromAddr;

		try {
			MimeMessage msg = new MimeMessage(session);
			String fromName = (set.getFn() != null && !set.getFn().trim().isEmpty()) ? set.getFn() : set.getCo();
			msg.setFrom(new InternetAddress(fromAddrFinal, fromName, "UTF-8"));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			if ("y".equals(set.getBcc()) && fromAddrFinal != null) {
				msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(fromAddrFinal));
			}
			msg.setSubject(subject, "UTF-8");

			String[] ym = (slip.getYm() != null ? slip.getYm() : "-").split("-");
			String monthLabel = ym.length == 2 ? (ym[0] + "년 " + Integer.parseInt(ym[1]) + "월") : slip.getYm();
			String bodyHtml = "<p>" + esc(slip.getName()) + "님, 안녕하세요.</p>"
					+ "<p>" + monthLabel + " 급여명세서를 첨부파일(PDF)로 보내드립니다.</p>"
					+ "<p style=\"color:#667570;font-size:12.5px\">본 메일은 본인에게만 발송된 개인정보입니다.</p>"
					+ "<p>" + esc(set.getCo()) + "</p>";

			MimeMultipart mp = new MimeMultipart("mixed");
			MimeBodyPart bodyPart = new MimeBodyPart();
			bodyPart.setContent(bodyHtml, "text/html; charset=UTF-8");
			mp.addBodyPart(bodyPart);

			byte[] pdf = buildSlipPdf(slip, set.getCo());
			MimeBodyPart pdfPart = new MimeBodyPart();
			DataSource ds = new ByteArrayDataSource(pdf, "application/pdf");
			pdfPart.setDataHandler(new DataHandler(ds));
			String fileName = "급여명세서_" + (slip.getYm() != null ? slip.getYm() : "") + "_" + slip.getName() + ".pdf";
			pdfPart.setFileName(javax.mail.internet.MimeUtility.encodeText(fileName, "UTF-8", "B"));
			mp.addBodyPart(pdfPart);

			msg.setContent(mp);

			Transport.send(msg);
		} catch (Exception e) {
			String trace = debugOut.toString("UTF-8").replaceAll("(?i)AUTH PLAIN [A-Za-z0-9+/=]+", "AUTH PLAIN (감춤)");
			throw new RuntimeException("SMTP 통신 로그:\n" + trace + "\n실패: " + e.getMessage(), e);
		}
	}

	private static String esc(Object x) {
		return String.valueOf(x).replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
	}

	private static String won(Double v) {
		long n = Math.round(v != null ? v : 0);
		return NumberFormat.getIntegerInstance(Locale.KOREA).format(n);
	}

	private byte[] buildSlipPdf(PayrollSlip slip, String companyName) throws Exception {
		Document doc = new Document(PageSize.A4, 40, 40, 40, 40);
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		PdfWriter.getInstance(doc, out);
		doc.open();

		BaseFont bf = BaseFont.createFont("C:/Windows/Fonts/malgun.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Font titleFont = new Font(bf, 18, Font.BOLD);
		Font subFont = new Font(bf, 11, Font.NORMAL);
		Font headFont = new Font(bf, 10, Font.BOLD);
		Font valFont = new Font(bf, 10, Font.NORMAL);
		Font totFont = new Font(bf, 10, Font.BOLD);
		Font netFont = new Font(bf, 13, Font.BOLD);

		String[] ymParts = (slip.getYm() != null ? slip.getYm() : "-").split("-");
		String titleYm = ymParts.length == 2 ? (ymParts[0] + "년 " + Integer.parseInt(ymParts[1]) + "월") : String.valueOf(slip.getYm());

		Paragraph title = new Paragraph(titleYm + " 급여명세서", titleFont);
		title.setAlignment(Element.ALIGN_CENTER);
		doc.add(title);
		Paragraph co = new Paragraph(companyName != null ? companyName : "", subFont);
		co.setAlignment(Element.ALIGN_CENTER);
		co.setSpacingAfter(16);
		doc.add(co);

		PdfPTable infoTbl = new PdfPTable(new float[] { 1, 2, 1.3f, 2 });
		infoTbl.setWidthPercentage(100);
		infoTbl.setSpacingAfter(10);
		infoTbl.addCell(headCell("성명", headFont));
		infoTbl.addCell(valCell(slip.getName(), valFont));
		infoTbl.addCell(headCell("사번 / 부서", headFont));
		infoTbl.addCell(valCell(slip.getWorkerNo() + " / " + (slip.getDept() != null ? slip.getDept() : "-"), valFont));
		doc.add(infoTbl);

		PdfPTable tbl = new PdfPTable(new float[] { 1.3f, 1, 1.3f, 1 });
		tbl.setWidthPercentage(100);
		tbl.setSpacingAfter(2);
		addRow(tbl, "기본급", slip.getBase(), "국민연금", slip.getNp(), headFont, valFont);
		addRow(tbl, "식대", slip.getMeal(), "건강보험", slip.getHi(), headFont, valFont);
		addRow(tbl, "직책수당", slip.getPos(), "장기요양", slip.getLt(), headFont, valFont);
		addRow(tbl, "차량유지비", slip.getCar(), "고용보험", slip.getEi(), headFont, valFont);
		addRow(tbl, "연장수당", slip.getOt(), "소득세", slip.getTax(), headFont, valFont);
		addRow(tbl, "야간수당", slip.getNight(), "지방소득세", slip.getLoc(), headFont, valFont);
		addRow(tbl, "토요수당", slip.getSat(), "연말정산", slip.getYj(), headFont, valFont);
		addRow(tbl, "특근수당", slip.getSpec(), "건강보험정산", slip.getHs(), headFont, valFont);
		addRow(tbl, "상여금", slip.getBonus(), "기타공제", slip.getOd(), headFont, valFont);
		PdfPCell g1 = headCell("지급합계", totFont); g1.setBackgroundColor(new java.awt.Color(0xe3, 0xf1, 0xed));
		PdfPCell g2 = valCell(won(slip.getGross()), totFont); g2.setBackgroundColor(new java.awt.Color(0xe3, 0xf1, 0xed));
		PdfPCell g3 = headCell("공제합계", totFont); g3.setBackgroundColor(new java.awt.Color(0xe3, 0xf1, 0xed));
		PdfPCell g4 = valCell(won(slip.getDed()), totFont); g4.setBackgroundColor(new java.awt.Color(0xe3, 0xf1, 0xed));
		tbl.addCell(g1); tbl.addCell(g2); tbl.addCell(g3); tbl.addCell(g4);
		doc.add(tbl);

		PdfPTable netTbl = new PdfPTable(new float[] { 1, 1 });
		netTbl.setWidthPercentage(100);
		netTbl.setSpacingBefore(10);
		PdfPCell nh = headCell("실수령액", netFont); nh.setBackgroundColor(new java.awt.Color(0xe3, 0xf1, 0xed));
		PdfPCell nv = valCell(won(slip.getNet()) + " 원", netFont); nv.setBackgroundColor(new java.awt.Color(0xe3, 0xf1, 0xed));
		netTbl.addCell(nh); netTbl.addCell(nv);
		doc.add(netTbl);

		Paragraph note = new Paragraph("※ 본 문서는 본인에게만 발송된 개인정보입니다.", new Font(bf, 9, Font.NORMAL, new java.awt.Color(0x66, 0x75, 0x70)));
		note.setSpacingBefore(14);
		doc.add(note);

		doc.close();
		return out.toByteArray();
	}

	private static void addRow(PdfPTable tbl, String label1, Double v1, String label2, Double v2, Font headFont, Font valFont) {
		tbl.addCell(headCell(label1, headFont));
		tbl.addCell(valCell(won(v1), valFont));
		tbl.addCell(headCell(label2, headFont));
		tbl.addCell(valCell(won(v2), valFont));
	}

	private static PdfPCell headCell(String text, Font font) {
		PdfPCell c = new PdfPCell(new Phrase(text, font));
		c.setPadding(6);
		c.setBackgroundColor(new java.awt.Color(0xf3, 0xf5, 0xf4));
		return c;
	}

	private static PdfPCell valCell(String text, Font font) {
		PdfPCell c = new PdfPCell(new Phrase(text, font));
		c.setPadding(6);
		c.setHorizontalAlignment(Element.ALIGN_RIGHT);
		return c;
	}

}
