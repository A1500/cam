package com.inspur.cams.sorg.upload.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;

/**
 * 社会组织电子档案查询
 * @author Muqi
 * @date 2011-7-19
 */
public class SomElectronicQueryCmd extends BaseQueryCommand {
	// 获取SCA组件
	private ISomElectronicDomain service = ScaComponentFactory.getService(ISomElectronicDomain.class,"somElectronicDomain/somElectronicDomain");
	
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
	public DataSet queryCatalog(){
		ParameterSet pset = getParameterSet();
		return service.queryCatalogBySql(pset);
	}
	public DataSet queryArchiveCatalog(){
		ParameterSet pset = getParameterSet();
		return service.queryArchiveCatalogBySql(pset);
	}
	public DataSet queryElectronic(){
		ParameterSet pset = getParameterSet();
		return service.queryElectronic(pset);
	}
	public DataSet queryPeopleCatalog(){
		ParameterSet pset = getParameterSet();
		return service.queryPeopleCatalogBySql(pset);
	}
	public DataSet queryPeopleElectronic(){
		ParameterSet pset = getParameterSet();
		return service.queryPeopleElectronic(pset);
	}
	public DataSet queryElectronicOnly(){
		ParameterSet pset = getParameterSet();
		return service.queryElectronicOnly(pset);
	}
	/**
	 * 根据sorgId查询社会组织的所有档案
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySorgId(){
		ParameterSet pset = getParameterSet();
		return service.queryElectronicBySorgId(pset);
	}
}
