package com.inspur.cams.fis.ep.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.ep.base.domain.IFisCemeCheckDomain;


/**
 * @title:InspectionQueryCommand
 * @description:
 * @author:
 * @since:2011-11-17
 * @version:1.0
*/
public class FisCemeCheckQueryCmd extends BaseQueryCommand{
	IFisCemeCheckDomain service = ScaComponentFactory.getService(IFisCemeCheckDomain.class,
	"FisCemeCheckDomain/FisCemeCheckDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	
	public DataSet queryForCemeInfo() {
		ParameterSet pset = getParameterSet();
		return service.queryForCemeInfo(pset);
	}
	
	public DataSet queryAccessories(){
		ParameterSet pset = getParameterSet();
		return service.queryAccessories(pset);
	}
	
	public DataSet queryAccessoriesItem(){
		ParameterSet pset = getParameterSet();
		return service.queryAccessoriesItem(pset);
	}
	
	public DataSet queryAudit(){
		ParameterSet pset = getParameterSet();
		return service.queryAudit(pset);
	}
	
	public DataSet queryScore(){
		ParameterSet pset = getParameterSet();
		return service.queryScore(pset);
	}
}
