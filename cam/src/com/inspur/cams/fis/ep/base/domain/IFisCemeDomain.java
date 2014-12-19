package com.inspur.cams.fis.ep.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.ep.base.data.FisCeme;

/**
 * @title:IFisCemeDomain
 * @description:公墓信息行业库domain接口
 * @since:2011-11-18
 * @version:1.0
 */
public interface IFisCemeDomain {
	public DataSet query(ParameterSet pset);
	public String queryPrint(ParameterSet pset);
	public String queryGYPrint(ParameterSet pset);
	public DataSet queryCemeBySql(ParameterSet pset);

	/**
	 * 查询统计到的公墓的详细信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryResult(ParameterSet pset);

	@Trans
	public void save(List<FisCeme> list);

	@Trans
	public void insert(FisCeme dataBean);

	@Trans
	public void update(FisCeme dataBean);

	@Trans
	public void delete(String[] delIds);

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