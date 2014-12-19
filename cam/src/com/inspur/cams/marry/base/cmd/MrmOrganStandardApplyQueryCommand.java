package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmOrganStandardApplyDomain;

/**
 * 婚姻登记机关等级评定标准业务表查询cmd
 * @author 
 * @date 2012-11-28
 */
public class MrmOrganStandardApplyQueryCommand extends BaseQueryCommand {

	private IMrmOrganStandardApplyDomain mrmOrganStandardApplyDomain = ScaComponentFactory
			.getService(IMrmOrganStandardApplyDomain.class, "mrmOrganStandardApplyDomain/mrmOrganStandardApplyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return mrmOrganStandardApplyDomain.query(pset);
	}

	public DataSet queryApply() {
		ParameterSet pset = getParameterSet();
		return mrmOrganStandardApplyDomain.queryApply(pset);
	}
	
}