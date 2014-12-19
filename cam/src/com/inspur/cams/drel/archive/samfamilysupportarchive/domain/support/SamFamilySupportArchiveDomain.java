package com.inspur.cams.drel.archive.samfamilysupportarchive.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.archive.samfamilysupportarchive.dao.ISamFamilySupportArchiveDao;
import com.inspur.cams.drel.archive.samfamilysupportarchive.data.SamFamilySupportArchive;
import com.inspur.cams.drel.archive.samfamilysupportarchive.domain.ISamFamilySupportArchiveDomain;

/**
 * 赡扶抚养人domain
 * @author 
 * @date 2012-06-28
 */
public class SamFamilySupportArchiveDomain implements ISamFamilySupportArchiveDomain {

	@Reference
	private ISamFamilySupportArchiveDao samFamilySupportArchiveDao;

	/**
	 * 查询 赡扶抚养人
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samFamilySupportArchiveDao.query(pset);
	}

	/**
	 * 获取 赡扶抚养人
	 * @param pset
	 * @return
	 */
	public SamFamilySupportArchive get(String supportArchiveId) {
		return samFamilySupportArchiveDao.get(supportArchiveId);
	}

	/**
	 * 增加 赡扶抚养人
	 * @param samFamilySupportArchive
	 */
	public void insert(SamFamilySupportArchive samFamilySupportArchive) {
		samFamilySupportArchiveDao.insert(samFamilySupportArchive);
	}
	
	/**
	 * 修改 赡扶抚养人
	 * @param samFamilySupportArchive
	 */
	public void update(SamFamilySupportArchive samFamilySupportArchive) {
		samFamilySupportArchiveDao.update(samFamilySupportArchive);
	}
	
	/**
	 * 删除 赡扶抚养人
	 * @param supportArchiveId
	 */
	public void delete(String supportArchiveId) {
		samFamilySupportArchiveDao.delete(supportArchiveId);
	}

}