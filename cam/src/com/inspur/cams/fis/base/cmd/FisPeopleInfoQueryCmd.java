package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisPeopleInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisPeopleInfoQueryCmd  
 * @Description: TODO 殡葬业务工作人员信息表查询Cmd
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisPeopleInfoQueryCmd extends BaseQueryCommand{
	IFisPeopleInfoDomain service = ScaComponentFactory.getService(IFisPeopleInfoDomain.class,
	"FisPeopleInfoDomain/FisPeopleInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	
	public DataSet queryForPeopleRecords() {
		ParameterSet pset = getParameterSet();
		return service.queryForPeopleRecords(pset);
	}

	// 获取服务所使用的人员
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
	
	/**
	 * 
	 * @Title: queryForPeopleService 
	 * @Description: TODO(查询人员服务量方法) 
	 * @param @return 设定文件 
	 * @return DataSet    返回类型
	 * @author wangziming
	 * @date 2011-12-13
	 */
	public DataSet queryForPeopleService(){
		ParameterSet pset = getParameterSet();
		return service.queryForPeopleService(pset);
	}
	
	/**
	 * @Description: TODO(查询人员服务量) 
	 */
	public DataSet querySumForServer(){
		ParameterSet pset = getParameterSet();
		return service.querySumForServer(pset);
	}

	/**
	 * @Description: 馆工作人员统计一
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeoSum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFuneralOrganPeoSum(pset);
		return ds;
	}

	/**
	 * @Description: 馆工作人员统计二
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeo2Sum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFuneralOrganPeo2Sum(pset);
		return ds;
	}

	/**
	 * @Description: 馆技术人员统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganTePeoSum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFuneralOrganTePeoSum(pset);
		return ds;
	}
}
