package com.tkheat.dao;

import java.util.List;

import com.tkheat.domain.FileAttach;
import com.tkheat.domain.FileFolder;

public interface FileManageDao {

	List<FileFolder> getFolderList();

	void insertFolder(FileFolder fileFolder);

	void renameFolder(FileFolder fileFolder);

	List<Integer> getFolderSubtreeCodes(int folder_code);

	List<FileAttach> getFilesInFolderSubtree(int folder_code);

	void deleteFilesByFolderSubtree(int folder_code);

	void deleteFolderSubtree(int folder_code);

	List<FileAttach> getFileList(int folder_code);

	void insertFile(FileAttach fileAttach);

	FileAttach getFileByCode(int file_code);

	void deleteFile(int file_code);
}
