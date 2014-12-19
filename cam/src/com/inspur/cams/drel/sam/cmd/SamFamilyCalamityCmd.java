package com.inspur.cams.drel.sam.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.drel.sam.data.SamFamilyCalamity;
import com.inspur.cams.drel.sam.domain.IBaseinfoFamilyDomain;

/**
 * @title:SamFamilyCalamityCmd自然灾害
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class SamFamilyCalamityCmd extends BaseQueryCommand {

	public DataSet execute() {
		IBaseinfoFamilyDomain baseinfoFamilyDomain = ScaComponentFactory.getService(IBaseinfoFamilyDomain.class,
		"SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		ParameterSet pset = getParameterSet();
		return baseinfoFamilyDomain.queryJtxxZrzh(pset);
	}

	public void save() {
		IBaseinfoFamilyDomain baseinfoFamilyDomain = ScaComponentFactory.getService(IBaseinfoFamilyDomain.class,
				"SamBaseinfoFamilyDomain/SamBaseinfoFamilyDomain");
		Record[] ygjzjtxxzrzhRecords = (Record[]) getParameter("ygjzjtxxzrzhRecords");
		List<SamFamilyCalamity> list = new ArrayList<SamFamilyCalamity>();
		for (int i = 0; i < ygjzjtxxzrzhRecords.length; i++) {
			SamFamilyCalamity ygjzjtxxzrzh = (SamFamilyCalamity)ygjzjtxxzrzhRecords[i].toBean(SamFamilyCalamity.class);
			list.add(ygjzjtxxzrzh);
		}
		baseinfoFamilyDomain.saveYgjzJtxxZrzh(list);
	}
	//自然灾害删除
	public void delete() {
		EntityDao<SamFamilyCalamity> dao = (EntityDao<SamFamilyCalamity>) DaoFactory
		.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamFamilyCalamityDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}