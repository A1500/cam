package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisEquipmentInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisEquipmentInfoQueryCmd  
 * @Description: TODO 殡葬业务设备表QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisEquipmentInfoQueryCmd extends BaseQueryCommand{
	
	IFisEquipmentInfoDomain service = ScaComponentFactory.getService(IFisEquipmentInfoDomain.class,
	"FisEquipmentInfoDomain/FisEquipmentInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	
	//查询统计模块中，殡仪车辆、火化设备、冷藏柜等List页面信息查询公用方法
	   public DataSet queryForEquipmentCount(){
		   ParameterSet pset = getParameterSet();
			return service.queryForEquipmentCount(pset);
	   }
	/**
	 * 
	 * @Title: queryForRefrigerated 
	 * @Description: TODO(冷藏柜信息查询) 
	 * @param @return 设定文件 
	 * @return DataSet    返回类型
	 * @author wangziming
	 * @date 2011-12-14
	 */
	public DataSet queryForRefrigerated(){
		ParameterSet pset = getParameterSet();
		return service.queryForRefrigerated(pset);
	}
	/**
	 * 
	 * @Title: queryForRefrigeratedService 
	 * @Description: TODO(冷藏柜使用记录查询) 
	 * @param @return 设定文件 
	 * @return DataSet    返回类型
	 * @author wangziming
	 * @date 2011-12-14
	 */
	public DataSet queryForRefrigeratedService(){
		ParameterSet pset = getParameterSet();
		return service.queryForRefrigeratedService(pset);
	}

	/**
	 * 
	 * @Title: queryForEmplacingService
	 * @Description: TODO(寄存设备使用记录查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author luguosui
	 * @date 2011-12-14
	 */
	public DataSet queryForEmplacingService(){
		ParameterSet pset = getParameterSet();
		return service.queryForEmplacingService(pset);
		
		
	}
}