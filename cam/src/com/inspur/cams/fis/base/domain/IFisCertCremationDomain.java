package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCertCremation;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisCertCremationDomain
 * @Description: TODO 殡葬业务火化证明表Domain的接口
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public interface IFisCertCremationDomain {

	public DataSet query(ParameterSet pset);

	/**
	 * @Title: queryForCremationCretList
	 * @Description: TODO(领灰证明列表查询方法)
	 * @param
	 * @param pset
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 */
	public DataSet queryForCremationCretList(ParameterSet pset);

	@Trans
	public void save(List<FisCertCremation> list);

	@Trans
	public void insert(FisCertCremation bean);
		
	@Trans
	public void insertAndUpdate(FisCertCremation bean);
	@Trans
	public void updateByCertId(ParameterSet pset);

	@Trans
	public void update(FisCertCremation bean);

	@Trans
	public void delete(String[] delIds);
	
	@Trans
	public DataSet queryCompleteHistory(ParameterSet pset);

	  /**
	  * @Title: queryCremationCertBriefInfo
	  * @Description: TODO(火化证明概要信息)
	  * @return DataSet  
	  * @throws
	  * @author luguosui
	   */
	public DataSet queryCremationCertBriefInfo(ParameterSet pset);

	/**
	* @Title: printCremationCertAfter
	* @Description: TODO(打印火化证明成功后操作) void  
	* @throws
	* @author luguosui
	 */
	@Trans
	public void printCremationCertAfter(ParameterSet pset);

	   /**
	   * @Title: queryCremationCertMsg
	   * @Description: TODO(查询当前火化证明信息)
	   * @return DataSet  
	   * @throws
	   * @author luguosui
	    */
	public DataSet queryCremationCertMsg(ParameterSet pset);

	public DataSet queryCertInfoAndCustomInfo(ParameterSet pset);

	public DataSet queryForExport(ParameterSet set);
}
