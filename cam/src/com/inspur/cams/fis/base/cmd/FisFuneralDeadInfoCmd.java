package com.inspur.cams.fis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisFuneralDeadInfo;
import com.inspur.cams.fis.base.domain.IFisFuneralDeadInfoDomain;

/**
* @Package com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoCmd
* @Description: 数据上报，逝者信息
* @author jiangzhaobao 
* @date 2012-4-5
 */
public class FisFuneralDeadInfoCmd extends BaseAjaxCommand{
	IFisFuneralDeadInfoDomain service = ScaComponentFactory.getService(IFisFuneralDeadInfoDomain.class,
	"FisFuneralDeadInfoDomain/FisFuneralDeadInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		FisFuneralDeadInfo dataBean=(FisFuneralDeadInfo)record.toBean(FisFuneralDeadInfo.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisFuneralDeadInfo dataBean=(FisFuneralDeadInfo)record.toBean(FisFuneralDeadInfo.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.delete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisFuneralDeadInfo> list = new ArrayList<FisFuneralDeadInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisFuneralDeadInfo dataBean = (FisFuneralDeadInfo) records[i].toBean(FisFuneralDeadInfo.class);
			list.add(dataBean);
		}

		service.save(list);
	}
}
