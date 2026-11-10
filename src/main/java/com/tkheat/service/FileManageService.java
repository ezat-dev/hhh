package com.tkheat.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.tkheat.domain.FileAttach;
import com.tkheat.domain.FileFolder;

public interface FileManageService {

	List<FileFolder> getFolderList();

	void insertFolder(FileFolder fileFolder);

	void renameFolder(FileFolder fileFolder);

	//폴더 자신 + 모든 하위폴더/파일을 통째로 삭제(실제 디스크 파일도 함께 삭제)
	void deleteFolder(int folder_code) throws IOException;

	List<FileAttach> getFileList(int folder_code);

	FileAttach uploadFile(int folder_code, MultipartFile file, String reg_user) throws IOException;

	FileAttach getFileByCode(int file_code);

	//DB 레코드 삭제 + 실제 디스크 파일 삭제
	void deleteFile(int file_code) throws IOException;
}
