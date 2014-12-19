package com.inspur.cams.drel.funds.release.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.funds.release.dao.ISamReleaseStatDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseStat;
import com.inspur.cams.drel.funds.release.domain.ISamReleaseStatDomain;

/**
 * @title:SamReleaseStatDomain
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
public class SamReleaseStatDomain implements ISamReleaseStatDomain{
	@Reference
	private ISamReleaseStatDao samReleaseStatDao;

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samReleaseStatDao.query(pset);
	}

	/**
	 * 增加
	 * @param samAssistanceItem
	 */
	public void insert(SamReleaseStat samReleaseStat) {
		samReleaseStatDao.insert(samReleaseStat);
	}

	/**
	 * 更新
	 * @param samAssistanceItem
	 */
	public void update(SamReleaseStat samReleaseStat) {
		samReleaseStatDao.update(samReleaseStat);
	}

	/**
	 * 删除
	 * @param key
	 */
	public void delete(String key) {
		samReleaseStatDao.delete(key);
	}

	/**
	 * 保存
	 * @param list
	 */
	public void save(List<SamReleaseStat> list) {
		samReleaseStatDao.save(list);
	}

	public DataSet queryStatistics(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samReleaseStatDao.queryStatistics(pset);
	}
}