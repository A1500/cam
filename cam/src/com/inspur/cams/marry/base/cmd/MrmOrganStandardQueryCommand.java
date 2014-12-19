package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmOrganStandardDomain;

/**
 * @title:等级评定标准查询command
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardQueryCommand extends BaseQueryCommand {
	private IMrmOrganStandardDomain mrmOrganStandardDomain = ScaComponentFactory
			.getService(IMrmOrganStandardDomain.class,
					"mrmOrganStandardDomain/mrmOrganStandardDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "seq");
		return mrmOrganStandardDomain.query(pset);
	}
}
