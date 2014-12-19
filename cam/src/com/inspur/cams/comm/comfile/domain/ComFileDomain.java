package com.inspur.cams.comm.comfile.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.comfile.dao.IComFileDao;
import com.inspur.cams.comm.comfile.data.ComFile;

/**
 * 文件附件domain
 * @author shgtch
 * @date 2012-3-2
 */
public class ComFileDomain implements IComFileDomain {
	
	@Reference
	private IComFileDao comFileDao;

	/**
	 * 查找文件附件
	 * @param fileId
	 * @return
	 */
	public ComFile find(String fileId) {
		return comFileDao.get(fileId);
	}
	/**
	 * 查找文件附件
	 * @param fileId
	 * @return
	 */
	public DataSet find(ParameterSet pset) {
		return comFileDao.query(pset);
	}
	/**
	 * 保存文件附件
	 * @param comFile
	 * @return
	 */
	public ComFile save(ComFile comFile) {
		return comFileDao.insert(comFile);
	}
	
	/**
	 * 更新文件附件
	 * @param comFile
	 * @return
	 */
	public ComFile update(ComFile comFile) {
		return comFileDao.updateWithFile(comFile);
	}
	
	/**
	 * 删除文件附件
	 * @param fileId
	 */
	public void delete(String fileId) {
		comFileDao.delete(fileId);
	}
	
}
