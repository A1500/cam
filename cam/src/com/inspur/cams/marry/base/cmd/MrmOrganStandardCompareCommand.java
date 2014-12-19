package com.inspur.cams.marry.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.data.MrmOrganStandardCompare;
import com.inspur.cams.marry.base.domain.IMrmOrganStandardCompareDomain;

/**
 * @title:等级评定标准对照command
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardCompareCommand extends BaseAjaxCommand {
	private IMrmOrganStandardCompareDomain mrmOrganStandardCompareDomain = ScaComponentFactory
			.getService(IMrmOrganStandardCompareDomain.class,
					"mrmOrganStandardCompareDomain/mrmOrganStandardCompareDomain");
	public void batchUpdate() {
		List<MrmOrganStandardCompare> list=new ArrayList<MrmOrganStandardCompare>();
		Record[] records = (Record[]) getParameter("records");
		if(records!=null){
			for (int i = 0; i < records.length; i++) {
				MrmOrganStandardCompare mrmOrganStandardCompare = (MrmOrganStandardCompare) records[i].toBean(MrmOrganStandardCompare.class);
				list.add(mrmOrganStandardCompare);
			}
			mrmOrganStandardCompareDomain.batchUpdate(list);
		}
		
	}
	public void insert() {
		Record record = (Record) getParameter("record");
		MrmOrganStandardCompare mrmOrganStandardCompare = (MrmOrganStandardCompare) record.toBean(MrmOrganStandardCompare.class);
		mrmOrganStandardCompare.setCompareId(IdHelp.getUUID32());
		mrmOrganStandardCompareDomain.insert(mrmOrganStandardCompare);
	}
	public void batchInsert() {
		Record[] records = (Record[]) getParameter("records");
		if(records!=null){
			for (int i = 0; i < records.length; i++) {
				MrmOrganStandardCompare mrmOrganStandardCompare = (MrmOrganStandardCompare) records[i].toBean(MrmOrganStandardCompare.class);
				mrmOrganStandardCompare.setCompareId(IdHelp.getUUID32());
				mrmOrganStandardCompareDomain.insert(mrmOrganStandardCompare);
			}
		}
	}
	public void update() {
		Record record = (Record) getParameter("record");
		MrmOrganStandardCompare mrmOrganStandardCompare = (MrmOrganStandardCompare) record.toBean(MrmOrganStandardCompare.class);
		mrmOrganStandardCompareDomain.update(mrmOrganStandardCompare);
	}
}
