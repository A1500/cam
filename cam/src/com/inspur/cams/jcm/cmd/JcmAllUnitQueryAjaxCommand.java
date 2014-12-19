package com.inspur.cams.jcm.cmd;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmAllUnitQueryDomain;

/**
 * @author 陈寿业
 *所有单位表 Command
 *date 2014-12-16
 */
public class JcmAllUnitQueryAjaxCommand extends BaseAjaxCommand {
	private static IJcmAllUnitQueryDomain jcmAllUnitQueryDomain = ScaComponentFactory.getService(IJcmAllUnitQueryDomain.class, "jcmAllUnitQueryDomain/jcmAllUnitQueryDomain");

}
