package com.inspur.cams.fis.base.cmd;

import java.util.*;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisEquipmentInfo;
import com.inspur.cams.fis.base.domain.IFisEquipmentInfoDomain;
/**
 * @Path com.inspur.cams.fis.base.cmd.FisEquipmentInfoCmd  
 * @Description: TODO 殡葬业务设备表Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisEquipmentInfoCmd extends BaseAjaxCommand{
	
	IFisEquipmentInfoDomain service = ScaComponentFactory.getService(IFisEquipmentInfoDomain.class,
	"FisEquipmentInfoDomain/FisEquipmentInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		FisEquipmentInfo dataBean=(FisEquipmentInfo)record.toBean(FisEquipmentInfo.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisEquipmentInfo dataBean=(FisEquipmentInfo)record.toBean(FisEquipmentInfo.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.delete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisEquipmentInfo> list = new ArrayList<FisEquipmentInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisEquipmentInfo dataBean = (FisEquipmentInfo) records[i].toBean(FisEquipmentInfo.class);
			list.add(dataBean);
		}

		service.save(list);
	}
}
