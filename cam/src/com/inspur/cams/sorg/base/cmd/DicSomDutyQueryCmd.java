package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.IDicSomDutyDomain;

/**
 * 社会组织职务查询cmd
 * @author Jiangzhaobao
 * @date 2011-6-18
 */
public class DicSomDutyQueryCmd extends BaseQueryCommand {
	
	private IDicSomDutyDomain somDutyDomain = ScaComponentFactory.getService(
			IDicSomDutyDomain.class, "dicSomDutyDomain/dicSomDutyDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somDutyDomain.query(pset);
	}
}
