/**
 * 
 */
package com.inspur.cams.jcm.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmAllPeopleQueryDomain;

/**
 * 所有人员cmd
 * 
 * @author xinming
 * @date 2014-12-15
 */
public class JcmAllPeopleQueryCmd extends BaseAjaxCommand {
	private IJcmAllPeopleQueryDomain jcmAllPeopleQueryDomain = ScaComponentFactory
			.getService(IJcmAllPeopleQueryDomain.class,
					"jcmAllPeopleQueryDomain/jcmAllPeopleQueryDomain");

}
