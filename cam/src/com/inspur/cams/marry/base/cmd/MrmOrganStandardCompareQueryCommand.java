package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmOrganStandardCompareDomain;

/**
 * @title:等级评定标准对照查询command
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardCompareQueryCommand extends BaseQueryCommand {
	private IMrmOrganStandardCompareDomain mrmOrganStandardCompareDomain = ScaComponentFactory
			.getService(IMrmOrganStandardCompareDomain.class,
					"mrmOrganStandardCompareDomain/mrmOrganStandardCompareDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "seq");
		return mrmOrganStandardCompareDomain.query(pset);
	}
}
