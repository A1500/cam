package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisResourceInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceInfoQueryCmd  
 * @Description: TODO 殡葬业务资源QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceInfoQueryCmd extends BaseQueryCommand {

	IFisResourceInfoDomain service = ScaComponentFactory.getService(
			IFisResourceInfoDomain.class,
			"FisResourceInfoDomain/FisResourceInfoDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.query(pset);
		ds.getMetaData().setIdProperty("resourceId");
		return ds;
	}
	
	/**
	 * 联合特征扩展表查询
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithExtend(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryWithExtend(pset);
		return ds;
	}
	
	/**
	 * 联合特征扩展表、墓价规则表查询
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPrice(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryWithPrice(pset);
		return ds;
	}
	/**
	 * 通过安葬申请表的墓穴位置 联合特征扩展表、墓价规则表查询
	 * @author muqi
	 * @return
	 */
	public DataSet queryWithPriceByBury(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryWithPriceByBury(pset);
		return ds;
	}
	/**
	* @Title: queryForMess
	* @Description: TODO(查询格位的相关信息)
	* @return DataSet  
	* @throws
	* @author jiangzhaobao
	 */
	public DataSet queryForMess(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryForMess(pset);
		ds.getMetaData().setIdProperty("RESOURCE_ID");
		return ds;
	}

	// 获取服务所使用的资源
	public DataSet executeForService() {
		ParameterSet pset = getParameterSet();
		String isServiceUse = (String)pset.getParameter("isServiceUse");
		DataSet ds = null;
		if("true".equals(isServiceUse)) {
			ds = service.queryForService(pset);
			ds.getMetaData().setIdProperty("resourceId");
		}else {
			ds = service.query(pset);
			ds.getMetaData().setIdProperty("resourceId");
		}
		return ds;
	}
	// 统计获取资源使用情况
	public DataSet executeForStatistics(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryForStatistics(pset);
		return ds;
	}
	/**
	* @Title: executeForCemeteryUsing
	* @Description: TODO(墓穴使用情况统计)
	* @return DataSet  
	* @throws
	* @author jiangzhaobao
	 */
	public DataSet executeForCemeteryUsing(){
		ParameterSet pset = getParameterSet();
		DataSet ds = service.executeForCemeteryUsing(pset);
		return ds;
	}
	
}