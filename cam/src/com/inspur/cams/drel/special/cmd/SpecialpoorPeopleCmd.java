package com.inspur.cams.drel.special.cmd;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.drel.special.domain.ISpecFamilyDomain;
import com.inspur.cams.drel.special.domain.ISpecPeopleDomain;

/**
 * 
 * SpecialpoorPeopleCmd
 * @description:
 * @author:
 * @since:2012-05-05
 * @version:1.0
 */
public class SpecialpoorPeopleCmd extends BaseAjaxCommand {
	private ISpecPeopleDomain specPeopleDomain = ScaComponentFactory.getService
		(ISpecPeopleDomain.class, "specPeopleDomain/specPeopleDomain");
}
