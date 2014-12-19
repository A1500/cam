package com.inspur.cams.drel.special.domain;

import java.math.BigDecimal;
import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.diccity.cmd.DicCityCommand;
import com.inspur.cams.comm.util.DicUtil;
import com.inspur.cams.comm.util.EnumUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.special.dao.ISpecialpoorFamilyDao;
import com.inspur.cams.drel.special.data.SpecialpoorFamily;
import com.inspur.cams.drel.special.data.SpecialpoorPeople;

/**
 * SpecFamilyDomain
 * 
 * @description:
 * @author:
 * @version:1.0
 */
public class SpecFamilyDomain implements ISpecFamilyDomain {
	@Reference
	private ISpecialpoorFamilyDao specialpoorFamilyDao;

	@Reference ISpecPeopleDomain specPeopleDomain;
	
	public DataSet query(ParameterSet pset) {
		return specialpoorFamilyDao.query(pset);
	}

	/**
	 * @Description: 特殊困难户分致贫原因统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByType(ParameterSet pset) {
		return specialpoorFamilyDao.querySpecialpoorSumByType(pset);
	}

	/**
	 * @Description: 特殊困难户分地区统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByArea(ParameterSet pset) {
		return specialpoorFamilyDao.querySpecialpoorSumByArea(pset);
	}
	/**
	 * 保存
	 */
	public String saveFamily(SpecialpoorFamily specialpoorFamily) {
		List<SpecialpoorPeople> SpecialpoorPeopleList = specialpoorFamily.getSpecialpoorPeopleList();
		
		specialpoorFamily.setFamilyCardType("01");
		specialpoorFamily.setFlowFlag("0");
		specialpoorFamily.setPeopleNum( new BigDecimal( SpecialpoorPeopleList.size()));
		specialpoorFamily.setDomicileFullName(DicUtil.
				getTextValueFromDic("dic_city", "ID", specialpoorFamily.getDomicileCode(), "FULL_NAME"));
		if(!"".equals(specialpoorFamily.getHelpVillageCode())){
			specialpoorFamily.setHelpVillageName(EnumUtil.findTextFromEnum
					("SPECIALPOOR_HELP_VILLAGE","HELP_VILLAGE_CODE","HELP_VILLAGE_NAME",specialpoorFamily.getHelpVillageCode()));
		}
		//新增
		if("".equals(specialpoorFamily.getFamilyId()) || specialpoorFamily.getFamilyId() == null){
			String familyId=IdHelp.getUUID32();
			specialpoorFamily.setFamilyId(familyId);
			specialpoorFamilyDao.insert(specialpoorFamily);
			for (int i = 0; i < SpecialpoorPeopleList.size(); i++) {
				SpecialpoorPeople people = SpecialpoorPeopleList.get(i);
				people.setFamilyId(familyId);
				people.setPeopleId(IdHelp.getUUID32());
				people.setDomicileCode(specialpoorFamily.getDomicileCode());
				people.setDomicileName(specialpoorFamily.getDomicileName());
				specPeopleDomain.insert(people);
			}
		}else{//更新
			specialpoorFamilyDao.update(specialpoorFamily);
			specPeopleDomain.deleteAll(specialpoorFamily.getFamilyId());
			for (int i = 0; i < SpecialpoorPeopleList.size(); i++) {
				SpecialpoorPeople people = SpecialpoorPeopleList.get(i);
				people.setFamilyId(specialpoorFamily.getFamilyId());
				people.setPeopleId(IdHelp.getUUID32());
				people.setDomicileCode(specialpoorFamily.getDomicileCode());
				people.setDomicileName(specialpoorFamily.getDomicileName());
				specPeopleDomain.insert(people);
			}
		}
		
		
		return  specialpoorFamily.getFamilyId();
	}

	public void deleteFamily(String familyId) {
		specialpoorFamilyDao.deleteFamily(familyId);
	}
	/**
	 * 根据帮包村代码获取帮扶单位
	 */
	public String getSupportName(String helpVillageCode) {
		return specialpoorFamilyDao.getSupportName(helpVillageCode);
	}
	/**
	 * @Description: 特殊困难户省直单位统计
	 * @author yll
	 */
	public DataSet queryBySupport(ParameterSet pset) {
		return specialpoorFamilyDao.queryBySupport(pset);
	}

}
