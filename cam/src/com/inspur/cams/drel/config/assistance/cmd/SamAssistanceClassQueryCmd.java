package com.inspur.cams.drel.config.assistance.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.config.assistance.domain.ISamAssistanceClassDomain;

/**
 * @title:分类施保配置queryCmd
 * @description:
 * @author:
 * @since:2012-05-02
 * @version:1.0
*/
public class SamAssistanceClassQueryCmd extends BaseQueryCommand{
	private ISamAssistanceClassDomain samAssistanceClassDomain = ScaComponentFactory.getService(ISamAssistanceClassDomain.class, "samAssistanceClassDomain/samAssistanceClassDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samAssistanceClassDomain.query(pset);
	}
}
