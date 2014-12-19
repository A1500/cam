package com.inspur.cams.drel.archive.baseinfopeoplearchive.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public interface IBaseinfoPeopleArchiveDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(BaseinfoPeopleArchive baseinfoPeopleArchive);

	@Trans
	public void update(BaseinfoPeopleArchive baseinfoPeopleArchive);

	@Trans
	public void delete(String key);
	
	@Trans
	public void save(List<BaseinfoPeopleArchive> list);

	public DataSet queryPeopleDetail(ParameterSet pset);

	/**
	* @Title: queryPeopleForSamArchive
	* @Description: TODO(人员列表)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryPeopleForSamArchive(ParameterSet pset);
}
