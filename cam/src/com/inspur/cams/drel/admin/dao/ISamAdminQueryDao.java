package com.inspur.cams.drel.admin.dao;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;

public interface ISamAdminQueryDao extends BaseCURD<BaseinfoFamilyArchive>{
	/**
	    * 查询目前正在享受低保的家庭户数总数、总钱数,城市、农村、五保的户数、钱数，
	    * @param pset
	    * @return
	    */
	public DataSet queryBaseFamilyCaseNow(ParameterSet pset);
	/**
	    *  最近6个月的人数和户数统计
	    * @param pset
	    * @return
	    */
	public DataSet queryBaseChangeByMonth(ParameterSet pset);
	
	public DataSet queryBaseChange();
	 
}

