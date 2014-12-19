package com.inspur.cams.fis.ep.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.ep.base.data.FisCeme;


/**
 * @title:IFisCemeDao
 * @description:公墓行业库dao接口
 * @author:lidongdong
 * @since:2011-11-11
 * @version:1.0
*/
 public interface IFisCemeDao extends BaseCURD<FisCeme>{
	public void save(List<FisCeme> list);

	public DataSet queryResult(ParameterSet pset);
	public DataSet queryCemeBySql(ParameterSet pset);


	/**
	 * 查询公墓系统上报信息（公墓部署）
	 * @return
	 */
	public DataSet queryImportCemeInfo(ParameterSet pset);

	/**
	 * @Description: 公墓树查询
	 * @author xuexzh
	 */
	public DataSet queryOrganByUnitId(ParameterSet pset);
}

