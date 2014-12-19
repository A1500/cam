package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.domain.ISamGeroKeptPersonDomain;

/**
 * 供养对象信息表查询cmd
 * @author 
 * @date 2012-10-24
 */
public class SamGeroKeptPersonQueryCmd extends BaseQueryCommand {

	private ISamGeroKeptPersonDomain samGeroKeptPersonDomain = ScaComponentFactory
			.getService(ISamGeroKeptPersonDomain.class, "samGeroKeptPersonDomain/samGeroKeptPersonDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samGeroKeptPersonDomain.query(pset);
	}
	//查询入出院供养对象列表
	public DataSet queryInoutList(){
		ParameterSet pset = getParameterSet();
		return samGeroKeptPersonDomain.queryInoutList(pset);
	}
	//维护查体名册时，增加时查询不在查体名册的人员
	public DataSet queryInsertPerson(){
		ParameterSet pset = getParameterSet();
		return samGeroKeptPersonDomain.queryInsertPerson(pset);
	}
	//统计五保供养对象信息表
	public DataSet reportSupportInfo(){
		ParameterSet pset=getParameterSet();
		return samGeroKeptPersonDomain.reportSupportInfo(pset);
	}
	//入出院记录信息查询表
	public DataSet queryInoutRecord(){
		ParameterSet pset=getParameterSet();
		return samGeroKeptPersonDomain.queryInoutRecord(pset);
	}
}