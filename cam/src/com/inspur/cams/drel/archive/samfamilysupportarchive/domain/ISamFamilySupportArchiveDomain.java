package com.inspur.cams.drel.archive.samfamilysupportarchive.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.samfamilysupportarchive.data.SamFamilySupportArchive;

/**
 * 赡扶抚养人domain
 * @author 
 * @date 2012-06-28
 */
public interface ISamFamilySupportArchiveDomain {

	/**
	 * 查询 赡扶抚养人
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 赡扶抚养人
	 * @param pset
	 * @return
	 */
	public SamFamilySupportArchive get(String supportArchiveId);

	/**
	 * 增加 赡扶抚养人
	 * @param samFamilySupportArchive
	 */
	@Trans
	public void insert(SamFamilySupportArchive samFamilySupportArchive);
	
	/**
	 * 修改 赡扶抚养人
	 * @param samFamilySupportArchive
	 */
	@Trans
	public void update(SamFamilySupportArchive samFamilySupportArchive);
	
	/**
	 * 删除 赡扶抚养人
	 * @param supportArchiveId
	 */
	@Trans
	public void delete(String supportArchiveId);

}