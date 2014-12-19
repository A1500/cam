package com.inspur.cams.drel.sam.domain.support;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoFamilyDao;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.drel.sam.dao.ISamFamilyAssistanceDao;
import com.inspur.cams.drel.sam.dao.ISamFamilyCalamityDao;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyCalamity;
import com.inspur.cams.drel.sam.domain.IBaseinfoFamilyDomain;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;
/**
 * @title:BaseinfoFamilyDomain
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
 */
public class BaseinfoFamilyDomain implements IBaseinfoFamilyDomain {
	@Reference
	private IBaseinfoFamilyDao baseInfoFamilyDao;
	@Reference
	private IBaseinfoPeopleDao baseInfoPeopleDao;
	@Reference
	private IBaseinfoPeopleDomain baseInfoPeopleDomain;
	@Reference
	private ISamFamilyAssistanceDao samFamilyAssistanceDao;
	@Reference
	private ISamFamilyCalamityDao samfamilycalamitydao;
	//低保用


	public void saveYgjzJtxx(List<BaseinfoFamily> list) {
		this.baseInfoFamilyDao.save(list);

	}

	/**
	 * 得到系统时间
	 *
	 * @param format
	 * @return
	 */
	public static String getDatebyAddYears(String format, int iYear) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, iYear);
		Date date = cal.getTime();
		return sdf.format(date);
	}

	public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list) {
		if (list != null && !list.isEmpty()) {
			this.baseInfoPeopleDomain.saveYgjzJtxxCyxx(list);
		}
	}

	public DataSet queryYgjzJtxxCyxx(ParameterSet pset) {
		return baseInfoPeopleDao.query(pset);
	}

	public DataSet itemQuery(ParameterSet pset) {
		return baseInfoPeopleDao.itemQuery(pset);
	}
	/**
	 * 家庭信息、成员信息 主表添加全部信息
	 *
	 * @param ygjzjtxx
	 * @param line
	 * @param cjxxlist
	 */
	public void saveYgjzJtxxCyxxList(BaseinfoFamily ygjzjtxx,
			List<BaseinfoPeople> line) {
		IBaseinfoPeopleDomain service = ScaComponentFactory.getService(
				IBaseinfoPeopleDomain.class,
				"BaseinfoPeopleDomain/BaseinfoPeopleDomain");
		List ygjzjtxxList = new ArrayList();
		ygjzjtxxList.add(ygjzjtxx);
		this.baseInfoFamilyDao.save(ygjzjtxxList);

		if (line != null && !line.isEmpty()) {
			service.saveYgjzJtxxCyxx(line);
		}

	}
    //变更页面点提交按钮时，先批量删除救助类型记录，再执行保存方法
	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list, String familyId) {
        //先根据familyId删除相关的救助记录
		this.samFamilyAssistanceDao.deleteByFamilyId(familyId);
		//循环保存修改后的救助记录
		for(int i=0;i<list.size();i++){
			SamFamilyAssistance somA=(SamFamilyAssistance)list.get(i);
			samFamilyAssistanceDao.insert(somA);
		}
	}

	public DataSet querySamFamilyAssistance(ParameterSet pset) {
		return samFamilyAssistanceDao.query(pset);
	}

	public void saveSamFamilyAssistanceList(BaseinfoFamily ygjzjtxx, List<SamFamilyAssistance> line) {
		List<BaseinfoFamily> ygjzjtxxList = new ArrayList<BaseinfoFamily>();
		ygjzjtxxList.add(ygjzjtxx);
		this.baseInfoFamilyDao.save(ygjzjtxxList);
		if (line != null && !line.isEmpty()) {
			this.samFamilyAssistanceDao.save(line);
		}
	}

	public void delete(List<String> list) {
		String[] ygjzjtxxIds = list.toArray(new String[list.size()]);

		if (list != null && !list.isEmpty()) {
			this.baseInfoFamilyDao.batchDelete(ygjzjtxxIds);
		}

	}

	public DataSet queryYgjzJtxx(ParameterSet pset) {
		return baseInfoFamilyDao.query(pset);
	}

	public void setYgjzjtxxcyxxDomain(IBaseinfoPeopleDomain ygjzjtxxcyxxDomain) {
		this.baseInfoPeopleDomain = ygjzjtxxcyxxDomain;
	}

	// 更新成员数量
	public void updatePeopleNum(String familyId) {
		this.baseInfoFamilyDao.updatePeopleNum(familyId);
	}

	// 更改当前环节
	public void updateCurrentActivity(String activity, String jtids,String createOrgan) {
		this.baseInfoFamilyDao.updateCurrentActivity(activity, jtids,createOrgan);
	}
	/*
	 * jiang 批量插入救助类型
	 * @see com.inspur.cams.drel.sam.domain.IBaseinfoFamilyDomain#saveSamFamilyAssistance(java.util.List)
	 */
	public void saveSamFamilyAssistance(List<SamFamilyAssistance> list) {
		for(int i=0;i<list.size();i++){
			SamFamilyAssistance somA=(SamFamilyAssistance)list.get(i);
			samFamilyAssistanceDao.insert(somA);
		}
	}
	private String n2b(String str){
		return str == null ? "" : str.trim();
	}

	public void updateJtdz(String jtids) {
		this.baseInfoFamilyDao.updateJtdz(jtids);
	}
    //更新家庭
	public void updateFamily(BaseinfoFamily baseinfoFamily){
		baseInfoFamilyDao.update(baseinfoFamily);
	}
	//家庭自然灾害保存
	public void saveYgjzJtxxZrzh(List<SamFamilyCalamity> list) {

		if (list != null ) {
			this.samfamilycalamitydao.save(list);
		}
	}
	//家庭自然灾害查询
	public DataSet queryJtxxZrzh(ParameterSet pset) {
		return samfamilycalamitydao.query(pset);
	}
	/**
	 * 低保查询家庭基本信息
	 * @return
	 */
	public DataSet querySamFamily(ParameterSet pset) {
		return baseInfoFamilyDao.querySamFamily(pset);
	}
	
}