package com.inspur.cams.drel.special.cmd;
import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.drel.special.data.SpecialpoorFamily;
import com.inspur.cams.drel.special.data.SpecialpoorPeople;
import com.inspur.cams.drel.special.domain.ISpecFamilyDomain;

/**
 * 
 * @title:SpecialpoorFamilyCmd
 * @description:
 * @author:
 * @since:2012-05-05
 * @version:1.0
 */
public class SpecialpoorFamilyCmd extends BaseAjaxCommand {
	private ISpecFamilyDomain specFamilyDomain = ScaComponentFactory.getService(ISpecFamilyDomain.class, "specFamilyDomain/specFamilyDomain");
	
	public void saveFamily(){
		Record familyRecord = (Record) getParameter("familyRecord");
		Record[] peoples = (Record[]) getParameter("peoples");
		
		SpecialpoorFamily specialpoorFamily =(SpecialpoorFamily)familyRecord.toBean(SpecialpoorFamily.class);
		
		List<SpecialpoorPeople> SpecialpoorPeopleList = new ArrayList<SpecialpoorPeople>(); 
		if(peoples != null){
			for(int i=0;i<peoples.length;i++){
				SpecialpoorPeople specialpoorPeople=(SpecialpoorPeople)peoples[i].toBean(SpecialpoorPeople.class);
				SpecialpoorPeopleList.add(specialpoorPeople);
			}
		}
		specialpoorFamily.setSpecialpoorPeopleList(SpecialpoorPeopleList);
		String familyId = specFamilyDomain.saveFamily(specialpoorFamily);
		setReturn("familyId", familyId);
	}
	/**
	 * 根据帮包村代码获取帮扶单位
	 */
	public void getSupportName(){
		
		String helpVillageCode = (String) getParameter("helpVillageCode");
		String supportName = specFamilyDomain.getSupportName(helpVillageCode);
		System.out.println("supportName="+supportName);
		setReturn("supportName", supportName);
	}
	public void deleteFamily(){
		
		String familyId = (String)getParameter("familyId");
		specFamilyDomain.deleteFamily(familyId);
	}
}
