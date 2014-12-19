package com.inspur.cams.marry.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.data.MrmOrganStandard;
import com.inspur.cams.marry.base.domain.IMrmOrganStandardDomain;

/**
 * @title:等级评定标准command
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardCommand extends BaseAjaxCommand {
	private IMrmOrganStandardDomain mrmOrganStandardDomain = ScaComponentFactory
			.getService(IMrmOrganStandardDomain.class,
					"mrmOrganStandardDomain/mrmOrganStandardDomain");

	public void getMrmOrganStandard() {
		String famula="";
		String note="";
		ParameterSet pset = getParameterSet();
		DataSet ds = mrmOrganStandardDomain.getMrmOrganStandard(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			MrmOrganStandard mrmOrganStandard=(MrmOrganStandard) ds.getRecord(i).toBean(MrmOrganStandard.class);	
			if(i>0){
				famula+=",";
				if("null".equals(note)){
					note="";
				}else{
					note+="<BR/>";					
				}
			}
			famula+=(String) mrmOrganStandard.getFamula();
			note+=(String) mrmOrganStandard.getNote();	
		}			
		setReturn("famula",famula);
		setReturn("note",note);		
	}
	public void batchUpdate() {
		List<MrmOrganStandard> list=new ArrayList<MrmOrganStandard>();
		Record[] records = (Record[]) getParameter("records");
		for (int i = 0; i < records.length; i++) {
			MrmOrganStandard mrmOrganStandard = (MrmOrganStandard) records[i].toBean(MrmOrganStandard.class);
			list.add(mrmOrganStandard);
		}
		mrmOrganStandardDomain.batchUpdate(list);
	}
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmOrganStandard mrmOrganStandard = (MrmOrganStandard) record.toBean(MrmOrganStandard.class);
		mrmOrganStandardDomain.insert(mrmOrganStandard);
	}
	public void update() {
		Record record = (Record) getParameter("record");
		MrmOrganStandard mrmOrganStandard = (MrmOrganStandard) record.toBean(MrmOrganStandard.class);
		mrmOrganStandardDomain.update(mrmOrganStandard);
	}
}
