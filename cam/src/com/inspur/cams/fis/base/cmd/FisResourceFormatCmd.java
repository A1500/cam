package com.inspur.cams.fis.base.cmd;

import java.util.*;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisResourceFormat;
import com.inspur.cams.fis.base.domain.IFisResourceFormatDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceFormatCmd  
 * @Description: TODO 殡葬业务资源规格Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceFormatCmd extends BaseAjaxCommand{
	
	IFisResourceFormatDomain service = ScaComponentFactory.getService(IFisResourceFormatDomain.class,
	"FisResourceFormatDomain/FisResourceFormatDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		FisResourceFormat dataBean=(FisResourceFormat)record.toBean(FisResourceFormat.class);
		service.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisResourceFormat dataBean=(FisResourceFormat)record.toBean(FisResourceFormat.class);
		service.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		service.delete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisResourceFormat> list = new ArrayList<FisResourceFormat>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisResourceFormat dataBean = (FisResourceFormat) records[i].toBean(FisResourceFormat.class);
			list.add(dataBean);
		}

		service.save(list);
	}
}