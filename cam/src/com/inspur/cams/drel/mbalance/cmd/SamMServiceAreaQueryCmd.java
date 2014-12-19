package com.inspur.cams.drel.mbalance.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.mbalance.domain.ISamMServiceAreaDomain;
/**
 * 医院入院备案对象属地配置查询command
 * @author lgs
 *
 */


public class SamMServiceAreaQueryCmd extends BaseQueryCommand{
	
	private ISamMServiceAreaDomain samMServiceAreaDomain=ScaComponentFactory.getService(ISamMServiceAreaDomain.class, "samMServiceAreaDomain/samMServiceAreaDomain");

	
	public DataSet execute(){
		ParameterSet pset=getParameterSet();
		return samMServiceAreaDomain.query(pset);
	}
	
}