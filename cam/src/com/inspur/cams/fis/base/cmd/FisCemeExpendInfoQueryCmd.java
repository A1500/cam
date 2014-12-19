package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeExpendInfoDomain;

/**
 * ����ҵ��������Ĺ������查询cmd
 * @author 
 * @date 2013-09-29
 */
public class FisCemeExpendInfoQueryCmd extends BaseQueryCommand {

	private IFisCemeExpendInfoDomain fisCemeExpendInfoDomain = ScaComponentFactory
			.getService(IFisCemeExpendInfoDomain.class, "fisCemeExpendInfoDomain/fisCemeExpendInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeExpendInfoDomain.query(pset);
	}
	
}