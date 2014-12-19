package com.inspur.cams.drel.archive.baseinfopeoplearchive.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive;

/**
 * @title:IBaseinfoPeopleArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public interface IBaseinfoPeopleArchiveDao extends BaseCURD<BaseinfoPeopleArchive>{
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

