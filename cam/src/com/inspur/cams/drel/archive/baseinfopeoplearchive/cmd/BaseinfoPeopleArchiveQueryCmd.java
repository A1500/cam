package com.inspur.cams.drel.archive.baseinfopeoplearchive.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.domain.IBaseinfoPeopleArchiveDomain;

/**
 * @title:BaseinfoPeopleArchiveQueryCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class BaseinfoPeopleArchiveQueryCmd extends BaseQueryCommand{
	private IBaseinfoPeopleArchiveDomain service = ScaComponentFactory.getService(
			IBaseinfoPeopleArchiveDomain.class,"BaseinfoPeopleArchiveDomain/BaseinfoPeopleArchiveDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BaseinfoPeopleArchive> dao = (EntityDao<BaseinfoPeopleArchive>) DaoFactory
				.getDao("com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.jdbc.BaseinfoPeopleArchiveDao");
		return dao.query(pset);
	}
	
	/**
	 * @Title: queryPeopleDetail 
	 * @Description: TODO(人员详细信息查询) 
	 * @author wangziming
	 */
	public DataSet queryPeopleDetail(){
		ParameterSet pset = getParameterSet();
		return service.queryPeopleDetail(pset);
	}
	/**
	* @Title: queryPeopleForSamArchive
	* @Description: TODO(人员列表)
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryPeopleForSamArchive() {
		ParameterSet pset = getParameterSet();
		return service.queryPeopleForSamArchive(pset);
	}
}
