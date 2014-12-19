package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisFacilitiesInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisFacilitiesInfoQueryCmd  
 * @Description: TODO 殡葬业务设施表QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisFacilitiesInfoQueryCmd extends BaseQueryCommand{
	
	IFisFacilitiesInfoDomain service = ScaComponentFactory.getService(IFisFacilitiesInfoDomain.class,
	"FisFacilitiesInfoDomain/FisFacilitiesInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	/**
	 * 
	 * @Title: queryForsFacilitiesInfo 
	 * @Description: TODO(告别厅信息查询) 
	 * @param @return 设定文件 
	 * @return DataSet    返回类型
	 * @author wangziming
	 * @date 2011-12-15
	 */
	public DataSet queryForsFacilitiesInfo(){
		ParameterSet pset = getParameterSet();
		return service.queryForsFacilitiesInfo(pset);
	}
	/**
	 * 
	 * @Title: queryForFacilitiesService 
	 * @Description: TODO(告别厅使用记录查询) 
	 * @param @return 设定文件 
	 * @return DataSet    返回类型
	 * @author wangziming
	 * @date 2011-12-15
	 */
	public DataSet queryForFacilitiesService(){
		ParameterSet pset = getParameterSet();
		return service.queryForFacilitiesService(pset);
	}
}