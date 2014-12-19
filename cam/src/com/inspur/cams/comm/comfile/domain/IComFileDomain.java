package com.inspur.cams.comm.comfile.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.comfile.data.ComFile;

/**
 * 文件附件domain接口
 * @author shgtch
 * @date 2012-3-2
 */
public interface IComFileDomain {

	/**
	 * 查找文件附件
	 * @param fileId
	 * @return
	 */
	public ComFile find(String fileId);
	
	/**
	 * 查找文件附件
	 * @param fileId
	 * @return
	 */
	public DataSet find(ParameterSet pset);
	
	/**
	 * 保存文件附件
	 * @param comFile
	 * @return
	 */
	@Trans
	public ComFile save(ComFile comFile);
	
	/**
	 * 更新文件附件
	 * @param comFile
	 * @return
	 */
	@Trans
	public ComFile update(ComFile comFile);
	
	/**
	 * 删除文件附件
	 * @param fileId
	 */
	@Trans
	public void delete(String fileId);
	
}
