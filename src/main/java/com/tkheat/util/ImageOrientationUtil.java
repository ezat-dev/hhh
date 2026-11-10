package com.tkheat.util;

import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

import javax.imageio.ImageIO;

public class ImageOrientationUtil {

	//휴대폰 카메라로 찍은 JPEG에는 EXIF Orientation 태그가 있어 브라우저 <img>는 자동으로 돌려서 보여주지만,
	//JasperReports의 이미지 로더(ImageIO 기반)는 이 태그를 무시하고 원본 픽셀 그대로 그려서 열처리수주서
	//PDF에서 사진이 90도 돌아간 채로 출력됨 - 업로드 시점에 픽셀 자체를 바로잡아 저장해 두 경로 모두 동일하게 보이게 함
	public static void normalizeOrientation(File file) {
		try {
			int orientation = readOrientation(file);
			if (orientation <= 1) return;

			BufferedImage src = ImageIO.read(file);
			if (src == null) return;

			BufferedImage dst = applyOrientation(src, orientation);

			String name = file.getName().toLowerCase();
			String formatName = name.endsWith(".png") ? "png" : "jpg";
			ImageIO.write(dst, formatName, file);
		} catch (Exception e) {
			//방향 보정에 실패해도 원본 업로드 자체는 이미 끝난 상태이므로 조용히 무시(사진이 없는 것보다 회전된 채로 있는게 낫다)
		}
	}

	private static int readOrientation(File file) throws IOException {
		try (RandomAccessFile raf = new RandomAccessFile(file, "r")) {
			if (raf.length() < 4) return 1;
			if (raf.readUnsignedByte() != 0xFF || raf.readUnsignedByte() != 0xD8) return 1; //JPEG 아님

			while (raf.getFilePointer() < raf.length() - 4) {
				int marker = raf.readUnsignedByte();
				if (marker != 0xFF) continue;
				int type = raf.readUnsignedByte();
				if (type == 0x01 || (type >= 0xD0 && type <= 0xD8)) continue;
				if (type == 0xD9 || type == 0xDA) break; //EOI / 스캔 시작 - 더 이상 APPn 없음

				int segLen = raf.readUnsignedShort();
				if (type == 0xE1) { //APP1 (Exif)
					byte[] seg = new byte[segLen - 2];
					raf.readFully(seg);
					Integer o = parseExifOrientation(seg);
					if (o != null) return o;
				} else {
					raf.seek(raf.getFilePointer() + (segLen - 2));
				}
			}
		}
		return 1;
	}

	private static Integer parseExifOrientation(byte[] seg) {
		if (seg.length < 10) return null;
		if (!(seg[0] == 'E' && seg[1] == 'x' && seg[2] == 'i' && seg[3] == 'f')) return null;

		int tiffStart = 6;
		boolean bigEndian;
		if (seg[tiffStart] == 'M' && seg[tiffStart + 1] == 'M') bigEndian = true;
		else if (seg[tiffStart] == 'I' && seg[tiffStart + 1] == 'I') bigEndian = false;
		else return null;

		int ifdOffset = readInt32(seg, tiffStart + 4, bigEndian);
		int ifdStart = tiffStart + ifdOffset;
		if (ifdStart + 2 > seg.length) return null;

		int numEntries = readInt16(seg, ifdStart, bigEndian);
		for (int i = 0; i < numEntries; i++) {
			int entryOffset = ifdStart + 2 + i * 12;
			if (entryOffset + 12 > seg.length) break;
			int tag = readInt16(seg, entryOffset, bigEndian);
			if (tag == 0x0112) { //Orientation tag
				return readInt16(seg, entryOffset + 8, bigEndian);
			}
		}
		return null;
	}

	private static int readInt16(byte[] b, int off, boolean bigEndian) {
		int b0 = b[off] & 0xFF, b1 = b[off + 1] & 0xFF;
		return bigEndian ? (b0 << 8 | b1) : (b1 << 8 | b0);
	}

	private static int readInt32(byte[] b, int off, boolean bigEndian) {
		int b0 = b[off] & 0xFF, b1 = b[off + 1] & 0xFF, b2 = b[off + 2] & 0xFF, b3 = b[off + 3] & 0xFF;
		return bigEndian ? (b0 << 24 | b1 << 16 | b2 << 8 | b3) : (b3 << 24 | b2 << 16 | b1 << 8 | b0);
	}

	private static BufferedImage applyOrientation(BufferedImage img, int orientation) {
		int w = img.getWidth(), h = img.getHeight();
		AffineTransform t = new AffineTransform();

		switch (orientation) {
			case 2: t.scale(-1.0, 1.0); t.translate(-w, 0); break;
			case 3: t.translate(w, h); t.rotate(Math.PI); break;
			case 4: t.scale(1.0, -1.0); t.translate(0, -h); break;
			case 5: t.rotate(Math.PI / 2); t.scale(1.0, -1.0); break;
			case 6: t.translate(h, 0); t.rotate(Math.PI / 2); break;
			case 7: t.scale(-1.0, 1.0); t.translate(-h, 0); t.rotate(Math.PI / 2); break;
			case 8: t.translate(0, w); t.rotate(-Math.PI / 2); break;
			default: return img;
		}

		boolean swapDims = orientation >= 5;
		int newW = swapDims ? h : w;
		int newH = swapDims ? w : h;

		int type = img.getType();
		if (type == BufferedImage.TYPE_CUSTOM) {
			type = img.getColorModel().hasAlpha() ? BufferedImage.TYPE_INT_ARGB : BufferedImage.TYPE_INT_RGB;
		}

		BufferedImage dst = new BufferedImage(newW, newH, type);
		Graphics2D g = dst.createGraphics();
		g.setTransform(t);
		g.drawImage(img, 0, 0, null);
		g.dispose();
		return dst;
	}
}
