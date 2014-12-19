package com.inspur.cams.drel.admin.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.admin.dao.ISamAdminQueryDao;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.domain.IBaseinfoPeopleArchiveDomain;


public class SamAdminQueryCmd extends BaseQueryCommand{
	
	private ISamAdminQueryDao service = ScaComponentFactory.getService(
			ISamAdminQueryDao.class,"SamAdminQueryDao/SamAdminQueryDao");
	/**
	    * 查询目前正在享受低保的家庭户数总数、总钱数,城市、农村、五保的户数、钱数，
	    * @param pset
	    * @return
	    */
	public DataSet queryBaseFamilyCaseNow(){
		ParameterSet pset = getParameterSet();
		return service.queryBaseFamilyCaseNow(pset);
	}
	/**
	    *  最近6个月的人数和户数统计
	    * @param pset
	    * @return
	    */
	public DataSet queryBaseChangeByMonth(){
		ParameterSet pset = getParameterSet();
		return service.queryBaseChangeByMonth(pset);
	}
	
	public DataSet queryBaseChange(){
		return service.queryBaseChange();
	}
}
