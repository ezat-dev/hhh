package com.tkheat.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tkheat.dao.FileManageDao;
import com.tkheat.domain.FileAttach;
import com.tkheat.domain.FileFolder;

@Service
public class FileManageServiceImpl implements FileManageService {

	//실제 첨부파일이 저장되는 물리 경로 - DB가 관리하는 논리적 폴더트리와는 별개로 한 곳에 평평하게 저장
	//(사용자가 자유롭게 만드는 폴더명을 그대로 실제 디렉토리명으로 쓰면 특수문자/길이 문제가 생길 수 있어서,
	//실제 파일은 고유한 이름으로 한 곳에 저장하고 DB의 FOLDER_CODE로만 소속을 관리함)
	private static final String UPLOAD_DIR = "D:/태경출력파일/파일관리";

	@Autowired
	private FileManageDao fileManageDao;

	@Override
	public List<FileFolder> getFolderList() {
		return fileManageDao.getFolderList();
	}

	@Override
	public void insertFolder(FileFolder fileFolder) {
		fileManageDao.insertFolder(fileFolder);
	}

	@Override
	public void renameFolder(FileFolder fileFolder) {
		fileManageDao.renameFolder(fileFolder);
	}

	@Override
	public void deleteFolder(int folder_code) throws IOException {
		List<FileAttach> files = fileManageDao.getFilesInFolderSubtree(folder_code);
		for (FileAttach fa : files) {
			deletePhysicalFile(fa.getSaved_name());
		}
		fileManageDao.deleteFilesByFolderSubtree(folder_code);
		fileManageDao.deleteFolderSubtree(folder_code);
	}

	@Override
	public List<FileAttach> getFileList(int folder_code) {
		return fileManageDao.getFileList(folder_code);
	}

	@Override
	public FileAttach uploadFile(int folder_code, MultipartFile file, String reg_user) throws IOException {
		File dir = new File(UPLOAD_DIR);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		String originalName = file.getOriginalFilename();
		String ext = "";
		if (originalName != null) {
			int dotIndex = originalName.lastIndexOf('.');
			if (dotIndex > 0) {
				ext = originalName.substring(dotIndex);
			}
		}

		String savedName = UUID.randomUUID().toString() + ext;
		File destination = new File(UPLOAD_DIR + "/" + savedName);
		file.transferTo(destination);

		FileAttach fileAttach = new FileAttach();
		fileAttach.setFolder_code(folder_code);
		fileAttach.setOriginal_name(originalName);
		fileAttach.setSaved_name(savedName);
		fileAttach.setFile_size(file.getSize());
		fileAttach.setReg_user(reg_user);

		fileManageDao.insertFile(fileAttach);

		return fileAttach;
	}

	@Override
	public FileAttach getFileByCode(int file_code) {
		return fileManageDao.getFileByCode(file_code);
	}

	@Override
	public void deleteFile(int file_code) throws IOException {
		FileAttach fileAttach = fileManageDao.getFileByCode(file_code);
		if (fileAttach != null) {
			deletePhysicalFile(fileAttach.getSaved_name());
		}
		fileManageDao.deleteFile(file_code);
	}

	private void deletePhysicalFile(String savedName) {
		if (savedName == null || savedName.isEmpty()) {
			return;
		}
		File f = new File(UPLOAD_DIR + "/" + savedName);
		if (f.exists()) {
			f.delete();
		}
	}
}
