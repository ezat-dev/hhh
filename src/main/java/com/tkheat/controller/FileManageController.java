package com.tkheat.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tkheat.domain.FileAttach;
import com.tkheat.domain.FileFolder;
import com.tkheat.service.FileManageService;

@Controller
public class FileManageController {

	@Autowired
	private FileManageService fileManageService;

	//파일관리 - 화면로드
	@RequestMapping(value = "/filemanage/fileManage", method = RequestMethod.GET)
	public String fileManage() {
		return "/filemanage/fileManage.jsp";
	}

	//전체 폴더 목록(플랫) - 화면에서 트리로 조립
	@RequestMapping(value = "/filemanage/getFolderList", method = RequestMethod.POST)
	@ResponseBody
	public List<FileFolder> getFolderList() {
		return fileManageService.getFolderList();
	}

	//폴더 생성
	@RequestMapping(value = "/filemanage/insertFolder", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertFolder(
			@RequestParam(required = false) Integer parent_code,
			@RequestParam String folder_name,
			@RequestParam(required = false) String reg_user) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		FileFolder fileFolder = new FileFolder();
		fileFolder.setParent_code(parent_code);
		fileFolder.setFolder_name(folder_name);
		fileFolder.setReg_user(reg_user);

		fileManageService.insertFolder(fileFolder);

		rtnMap.put("status", "OK");
		rtnMap.put("folder_code", fileFolder.getFolder_code());
		return rtnMap;
	}

	//폴더 이름변경
	@RequestMapping(value = "/filemanage/renameFolder", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> renameFolder(
			@RequestParam int folder_code,
			@RequestParam String folder_name) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		FileFolder fileFolder = new FileFolder();
		fileFolder.setFolder_code(folder_code);
		fileFolder.setFolder_name(folder_name);

		fileManageService.renameFolder(fileFolder);

		rtnMap.put("status", "OK");
		return rtnMap;
	}

	//폴더(+하위폴더/파일 전체) 삭제
	@RequestMapping(value = "/filemanage/deleteFolder", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFolder(@RequestParam int folder_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			fileManageService.deleteFolder(folder_code);
			rtnMap.put("status", "OK");
		} catch (IOException e) {
			e.printStackTrace();
			rtnMap.put("status", "NG");
			rtnMap.put("message", "삭제 중 오류가 발생했습니다.");
		}
		return rtnMap;
	}

	//특정 폴더의 파일 목록
	@RequestMapping(value = "/filemanage/getFileList", method = RequestMethod.POST)
	@ResponseBody
	public List<FileAttach> getFileList(@RequestParam int folder_code) {
		return fileManageService.getFileList(folder_code);
	}

	//파일 업로드(여러 개 동시 업로드 지원)
	@RequestMapping(value = "/filemanage/uploadFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadFile(
			@RequestParam int folder_code,
			@RequestParam("files") MultipartFile[] files,
			@RequestParam(required = false) String reg_user) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			for (MultipartFile file : files) {
				if (file != null && !file.isEmpty()) {
					fileManageService.uploadFile(folder_code, file, reg_user);
				}
			}
			rtnMap.put("status", "OK");
		} catch (IOException e) {
			e.printStackTrace();
			rtnMap.put("status", "NG");
			rtnMap.put("message", "업로드 중 오류가 발생했습니다.");
		}
		return rtnMap;
	}

	//파일 다운로드
	@RequestMapping(value = "/filemanage/downloadFile", method = RequestMethod.GET)
	public void downloadFile(@RequestParam int file_code, HttpServletResponse response) throws IOException {
		FileAttach fileAttach = fileManageService.getFileByCode(file_code);
		if (fileAttach == null) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return;
		}

		java.io.File physicalFile = new java.io.File("D:/태경출력파일/파일관리/" + fileAttach.getSaved_name());
		if (!physicalFile.exists()) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return;
		}

		String encodedFileName = URLEncoder.encode(fileAttach.getOriginal_name(), "UTF-8").replace("+", "%20");

		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"; filename*=UTF-8''" + encodedFileName);
		response.setContentLengthLong(physicalFile.length());

		try (java.io.FileInputStream fis = new java.io.FileInputStream(physicalFile);
				OutputStream os = response.getOutputStream()) {
			byte[] buffer = new byte[8192];
			int len;
			while ((len = fis.read(buffer)) != -1) {
				os.write(buffer, 0, len);
			}
			os.flush();
		}
	}

	//파일 삭제
	@RequestMapping(value = "/filemanage/deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int file_code) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			fileManageService.deleteFile(file_code);
			rtnMap.put("status", "OK");
		} catch (IOException e) {
			e.printStackTrace();
			rtnMap.put("status", "NG");
			rtnMap.put("message", "삭제 중 오류가 발생했습니다.");
		}
		return rtnMap;
	}
}
