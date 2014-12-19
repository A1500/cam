package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCertCremationDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisCertCremationQueryCmd  
 * @Description: TODO 殡葬业务火化证明表查询Cmd
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisCertCremationQueryCmd extends BaseQueryCommand{
	IFisCertCremationDomain service = ScaComponentFactory.getService(IFisCertCremationDomain.class,
	"FisCertCremationDomain/FisCertCremationDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	/**
	    * @Title: queryForCremationCretList 
	    * @Description: TODO(领灰证明列表查询方法) 
	    * @param @param pset
	    * @param @return 设定文件 
	    * @return DataSet    返回类型
	    */
	   public DataSet queryForCremationCretList(){
			ParameterSet pset = getParameterSet();
			return service.queryForCremationCretList(pset);
		   
	  }
	   /**
	   * @Title: queryCremationCertMsg
	   * @Description: TODO(查询当前火化证明信息)
	   * @return DataSet  
	   * @throws
	   * @author luguosui
	    */
	   public DataSet queryCremationCertMsg(){

			ParameterSet pset = getParameterSet();
			return service.queryCremationCertMsg(pset);
	   }
	  /**
	   * 
	   * @Title: queryCompleteHistory 
	   * @Description: TODO(补办历史查询) 
	   * @param @return 设定文件 
	   * @return DataSet    返回类型
	   */
	  public DataSet queryCompleteHistory(){
		  ParameterSet pset = getParameterSet();
		  return service.queryCompleteHistory(pset);
	  }
	  /**
	  * @Title: queryCremationCertBriefInfo
	  * @Description: TODO(火化证明概要信息)
	  * @return DataSet  
	  * @throws
	  * @author luguosui
	   */
	  public DataSet queryCremationCertBriefInfo() {
		  ParameterSet pset = getParameterSet();
		  return service.queryCremationCertBriefInfo(pset);
	}
	  /**
	   * @Title: queryCertInfoAndCustomInfo 
	   * @Description: TODO(打印历史证明信息查询) 
	   * @author wangziming
	   */
	  public DataSet queryCertInfoAndCustomInfo(){
		  ParameterSet pset = getParameterSet();
		  return service.queryCertInfoAndCustomInfo(pset);
	  }
}
