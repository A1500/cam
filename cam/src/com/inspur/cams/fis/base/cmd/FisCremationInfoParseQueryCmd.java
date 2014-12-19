package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCremationInfoParseDomain;

/**
 * �ϱ����������ѯ查询cmd
 * @author 
 * @date 2013-11-07
 */
public class FisCremationInfoParseQueryCmd extends BaseQueryCommand {

	private IFisCremationInfoParseDomain fisCremationInfoParseDomain = ScaComponentFactory
			.getService(IFisCremationInfoParseDomain.class, "fisCremationInfoParseDomain/fisCremationInfoParseDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCremationInfoParseDomain.query(pset);
	}
	
	public DataSet queryDs(){
		ParameterSet pset = getParameterSet();
		return fisCremationInfoParseDomain.queryDs(pset);
	}
	
}