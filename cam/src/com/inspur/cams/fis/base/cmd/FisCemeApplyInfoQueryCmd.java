package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeApplyInfoDomain;

/**
 * 公墓审批业务表查询cmd
 * 
 * @author
 * @date 2013-08-01
 */
public class FisCemeApplyInfoQueryCmd extends BaseQueryCommand {

	private IFisCemeApplyInfoDomain fisCemeApplyInfoDomain = ScaComponentFactory
			.getService(IFisCemeApplyInfoDomain.class,
					"fisCemeApplyInfoDomain/fisCemeApplyInfoDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.query(pset);
	}
	public DataSet queryCreate() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryCreate(pset);
	}
	public DataSet queryExpend() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryExpend(pset);
	}
	/**
	 * 查询验收业务
	 * */
	public DataSet queryYS() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryYS(pset);
	}
	/**
	 * 查询待办业务
	 * */
	public DataSet queryDaiban() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryDaiban(pset);
	}
	//公益性年检
	public DataSet queryPublic() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryPublic(pset);
	}

	public DataSet queryCeme() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryCeme(pset);

	}

	
	public DataSet queryCemeApply() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryCemeApply(pset);

	}
	public DataSet queryByCurActicity() {
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryByCurActicity(pset);

	}
	public DataSet queryAccessories(){
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryAccessories(pset);
	}
	
	public DataSet queryAccessoryType(){
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryAccessoryType(pset);
	}
	
	public DataSet queryAccessoriesItem(){
		ParameterSet pset = getParameterSet();
		return fisCemeApplyInfoDomain.queryAccessoriesItem(pset);
	}
}