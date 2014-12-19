package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.domain.IFisCremationInfoSumDomain;

/**
 * @title:FisDicCityCommand
 * @description:
 * @author:
 * @since:2012-02-10
 * @version:1.0
*/
public class FisCremationInfoSumCommand extends BaseAjaxCommand {
	private IFisCremationInfoSumDomain fisCremationInfoSumDomain = ScaComponentFactory.getService(IFisCremationInfoSumDomain.class,
			"fisCremationInfoSumDomain/fisCremationInfoSumDomain");

	
}
