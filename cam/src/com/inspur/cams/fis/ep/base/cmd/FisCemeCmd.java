package com.inspur.cams.fis.ep.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.fis.ep.base.data.FisCeme;
import com.inspur.cams.fis.ep.base.data.FisCemeGovApproval;
import com.inspur.cams.fis.ep.base.data.FisCemeItems;
import com.inspur.cams.fis.ep.base.data.FisCemeLandcard;
import com.inspur.cams.fis.ep.base.domain.IFisCemeDomain;


/**
 * @title:FisCemeCommand
 * @description:公墓信息cmd
 * @author:lidongdong
 * @since:2011-11-14
 * @version:1.0
*/
public class FisCemeCmd extends BaseAjaxCommand{
	 IFisCemeDomain service = ScaComponentFactory.getService(IFisCemeDomain.class,
		"FisCemeDomain/FisCemeDomain");

	public void insert() {
		List<FisCemeItems> itemList = new ArrayList<FisCemeItems>();
		List<FisCemeLandcard> landcardList = new ArrayList<FisCemeLandcard>();
		List<FisCemeGovApproval> govAppList = new ArrayList<FisCemeGovApproval>();
		
		Record record = (Record) getParameter("record");
		Record[] itemRecords = (Record[]) getParameter("itemRecords");
		Record[] landcardRecords = (Record[]) getParameter("landcardRecords");
		Record[] govAppRecords = (Record[]) getParameter("govAppRecords");
		FisCeme dataBean=(FisCeme)record.toBean(FisCeme.class);
		
		if(itemRecords==null)
			itemRecords=new Record[0];
		if(landcardRecords==null)
			landcardRecords=new Record[0];
		if(govAppRecords==null)
			govAppRecords=new Record[0];
		
		for(int i=0; i<itemRecords.length; i++) {
			FisCemeItems fisCemeItems=(FisCemeItems)itemRecords[i].toBean(FisCemeItems.class);
			fisCemeItems.setCemeId(dataBean.getCemeId());
			itemList.add(fisCemeItems);
		}
		
		for(int i=0; i<landcardRecords.length; i++) {
			FisCemeLandcard fisCemeLandcard=(FisCemeLandcard)landcardRecords[i].toBean(FisCemeLandcard.class);
			fisCemeLandcard.setCemeId(dataBean.getCemeId());
			if("".equals(fisCemeLandcard.getRecordId()))
				fisCemeLandcard.setRecordId(IdHelp.getUUID32());
			landcardList.add(fisCemeLandcard);
		}
		
		for(int i=0; i<govAppRecords.length; i++) {
			FisCemeGovApproval fisCemeGovApproval=(FisCemeGovApproval)govAppRecords[i].toBean(FisCemeGovApproval.class);
			fisCemeGovApproval.setCemeId(dataBean.getCemeId());
			if("".equals(fisCemeGovApproval.getRecordId()))
				fisCemeGovApproval.setRecordId(IdHelp.getUUID32());
			govAppList.add(fisCemeGovApproval);
		}
		
		dataBean.setItemList(itemList);
		dataBean.setLandcardList(landcardList);
		dataBean.setGovAppList(govAppList);
		service.insert(dataBean);
	}

	public void update() {
		List<FisCemeItems> itemList = new ArrayList<FisCemeItems>();
		List<FisCemeLandcard> landcardList = new ArrayList<FisCemeLandcard>();
		List<FisCemeGovApproval> govAppList = new ArrayList<FisCemeGovApproval>();
		
		Record record = (Record) getParameter("record");
		Record[] itemRecords = (Record[]) getParameter("itemRecords");
		Record[] landcardRecords = (Record[]) getParameter("landcardRecords");
		Record[] govAppRecords = (Record[]) getParameter("govAppRecords");
		FisCeme dataBean=(FisCeme)record.toBean(FisCeme.class);
		
		if(itemRecords==null)
			itemRecords=new Record[0];
		if(landcardRecords==null)
			landcardRecords=new Record[0];
		if(govAppRecords==null)
			govAppRecords=new Record[0];
		
		for(int i=0; i<itemRecords.length; i++) {
			FisCemeItems fisCemeItems=(FisCemeItems)itemRecords[i].toBean(FisCemeItems.class);
			fisCemeItems.setCemeId(dataBean.getCemeId());
			itemList.add(fisCemeItems);
		}
		
		for(int i=0; i<landcardRecords.length; i++) {
			FisCemeLandcard fisCemeLandcard=(FisCemeLandcard)landcardRecords[i].toBean(FisCemeLandcard.class);
			fisCemeLandcard.setCemeId(dataBean.getCemeId());
			if("".equals(fisCemeLandcard.getRecordId()))
				fisCemeLandcard.setRecordId(IdHelp.getUUID32());
			landcardList.add(fisCemeLandcard);
		}
		
		for(int i=0; i<govAppRecords.length; i++) {
			FisCemeGovApproval fisCemeGovApproval=(FisCemeGovApproval)govAppRecords[i].toBean(FisCemeGovApproval.class);
			fisCemeGovApproval.setCemeId(dataBean.getCemeId());
			if("".equals(fisCemeGovApproval.getRecordId()))
				fisCemeGovApproval.setRecordId(IdHelp.getUUID32());
			govAppList.add(fisCemeGovApproval);
		}
		
		dataBean.setItemList(itemList);
		dataBean.setLandcardList(landcardList);
		dataBean.setGovAppList(govAppList);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.delete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisCeme> list = new ArrayList<FisCeme>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisCeme dataBean = (FisCeme) records[i].toBean(FisCeme.class);
			list.add(dataBean);
		}

		service.save(list);
	}
	
	public void queryForJYPrint(){
		ParameterSet pset = getParameterSet();
		String str= service.queryPrint(pset);
		setReturn("str",str);
	}
	
	public void queryForGYPrint(){
		ParameterSet pset = getParameterSet();
		String str= service.queryGYPrint(pset);
		setReturn("str",str);
	}
}
