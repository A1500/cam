package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;

/**
 * 人员保存和修改
 */
public class SomPeopleCmd extends BaseAjaxCommand {
	private ISomPeopleDomain somPeopleDomain = ScaComponentFactory.getService(ISomPeopleDomain.class, "somPeopleDomain/somPeopleDomain");
	public void queryRestrictNum(){
		ParameterSet pset = getParameterSet();
		DataSet dset=somPeopleDomain.queryRestrict(pset);
		String ifLimit="";
		if(dset.getCount()>0){
			SomPeople somPeople=(SomPeople)dset.getRecord(0).toBean(SomPeople.class);
			ifLimit=somPeople.getIfLimit();
		}
		setReturn("restrictNum", dset.getCount());
		setReturn("ifLimit", ifLimit);
	}
}
