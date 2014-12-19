package com.inspur.cams.dis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.data.DicDisMaterialType;
import com.inspur.cams.dis.base.domain.IDicDisMaterialTypeDomain;

/**
 * 救灾发放物资类型(字典)cmd
 * @author 
 * @date 2012-11-05
 */
public class DicDisMaterialTypeCmd extends BaseAjaxCommand {

	private IDicDisMaterialTypeDomain dicDisMaterialTypeDomain = ScaComponentFactory
			.getService(IDicDisMaterialTypeDomain.class, "dicDisMaterialTypeDomain/dicDisMaterialTypeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicDisMaterialType dicDisMaterialType = (DicDisMaterialType) record.toBean(DicDisMaterialType.class);
		dicDisMaterialTypeDomain.insert(dicDisMaterialType);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicDisMaterialType dicDisMaterialType = (DicDisMaterialType) record.toBean(DicDisMaterialType.class);
		dicDisMaterialTypeDomain.update(dicDisMaterialType);
	}
	
	// 删除
	public void delete() {
		String code = (String) getParameter("code");
		dicDisMaterialTypeDomain.delete(code);
	}
	
	// 保存
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		List<DicDisMaterialType> recordList = new ArrayList<DicDisMaterialType>();
		for (int i = 0; i < records.length; i++) {
			DicDisMaterialType dicDisMaterialType = (DicDisMaterialType) records[i].toBean(DicDisMaterialType.class);
			recordList.add(dicDisMaterialType);
		}
		dicDisMaterialTypeDomain.save(recordList);
	}
}