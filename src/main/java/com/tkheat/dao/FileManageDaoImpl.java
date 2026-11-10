package com.tkheat.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.tkheat.domain.FileAttach;
import com.tkheat.domain.FileFolder;

@Repository
public class FileManageDaoImpl implements FileManageDao {

	@Resource(name = "session")
	private SqlSession sqlSession;

	@Override
	public List<FileFolder> getFolderList() {
		return sqlSession.selectList("fileManage.getFolderList");
	}

	@Override
	public void insertFolder(FileFolder fileFolder) {
		sqlSession.insert("fileManage.insertFolder", fileFolder);
	}

	@Override
	public void renameFolder(FileFolder fileFolder) {
		sqlSession.update("fileManage.renameFolder", fileFolder);
	}

	@Override
	public List<Integer> getFolderSubtreeCodes(int folder_code) {
		return sqlSession.selectList("fileManage.getFolderSubtreeCodes", folder_code);
	}

	@Override
	public List<FileAttach> getFilesInFolderSubtree(int folder_code) {
		return sqlSession.selectList("fileManage.getFilesInFolderSubtree", folder_code);
	}

	@Override
	public void deleteFilesByFolderSubtree(int folder_code) {
		sqlSession.delete("fileManage.deleteFilesByFolderSubtree", folder_code);
	}

	@Override
	public void deleteFolderSubtree(int folder_code) {
		sqlSession.delete("fileManage.deleteFolderSubtree", folder_code);
	}

	@Override
	public List<FileAttach> getFileList(int folder_code) {
		return sqlSession.selectList("fileManage.getFileList", folder_code);
	}

	@Override
	public void insertFile(FileAttach fileAttach) {
		sqlSession.insert("fileManage.insertFile", fileAttach);
	}

	@Override
	public FileAttach getFileByCode(int file_code) {
		return sqlSession.selectOne("fileManage.getFileByCode", file_code);
	}

	@Override
	public void deleteFile(int file_code) {
		sqlSession.delete("fileManage.deleteFile", file_code);
	}
}
