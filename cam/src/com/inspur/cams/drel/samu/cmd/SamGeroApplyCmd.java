package com.inspur.cams.drel.samu.cmd;

import java.math.BigDecimal;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.data.SamGeroApply;
import com.inspur.cams.drel.samu.domain.ISamGeroApplyDomain;
import com.inspur.cams.drel.samu.domain.ISamPocketApplyDomain;

/**
 * 敬老院业务主表cmd
 * @author 
 * @date 2012-10-24
 */
public class SamGeroApplyCmd extends BaseAjaxCommand {

	private ISamGeroApplyDomain samGeroApplyDomain = ScaComponentFactory
			.getService(ISamGeroApplyDomain.class, "samGeroApplyDomain/samGeroApplyDomain");
	private ISamPocketApplyDomain samPocketApplyDomain = ScaComponentFactory
	.getService(ISamPocketApplyDomain.class, "samPocketApplyDomain/samPocketApplyDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamGeroApply samGeroApply = (SamGeroApply) record.toBean(SamGeroApply.class);
		samGeroApplyDomain.insert(samGeroApply);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamGeroApply samGeroApply = (SamGeroApply) record.toBean(SamGeroApply.class);
		samGeroApplyDomain.update(samGeroApply);
	}
	
	// 删除
	public void delete() {
		String applyId = (String) getParameter("applyId");
		samGeroApplyDomain.delete(applyId);
	}
	// 登记查体名册时，增加查体信息
	public void insertCheck() {
		String gerocomiumName = (String) getParameter("gerocomiumName");
		String checkDate = (String) getParameter("checkDate");
		String checkResult = (String) getParameter("checkResult");
		samGeroApplyDomain.insertCheck(gerocomiumName,checkDate,checkResult);
	}
	// 维护查体名册时，更新查体信息
	public void saveCheck() {
		Record[] records = (Record[]) getParameter("records");
		samGeroApplyDomain.saveCheck(records);
	}
	//删除查体名册
	public void deleteCheckList() {
		String gerocomiumId = (String) getParameter("gerocomiumId");
		String checkDate = (String) getParameter("checkDate");
		samGeroApplyDomain.deleteCheckList(gerocomiumId,checkDate);
	}
	//保存零花钱发放@tr
	public void insertSave(){
		String gerocomiumName = (String) getParameter("gerocomiumName");
		String pocketYm = (String) getParameter("pocketYm");
		BigDecimal pocketMoney = new BigDecimal( getParameter("pocketMoney").toString());
		samPocketApplyDomain.insertSave(gerocomiumName,pocketYm,pocketMoney);
	}
	//保存服装发放@tr
	public void insertSaveCloth(){
		String gerocomiumName = (String) getParameter("gerocomiumName");
		String clothDate = (String) getParameter("clothDate");
		String clothType = (String) getParameter("clothType");
		BigDecimal clothNum = new BigDecimal(getParameter("clothNum").toString());
		samPocketApplyDomain.insertSaveCloth(gerocomiumName,clothDate,clothType,clothNum);
	}
	// 维护名册时，更新发放信息@tr
	public void saveCheckM() {
		Record[] records = (Record[]) getParameter("records");
		samGeroApplyDomain.saveCheckM(records);
	}
	// 维护名册时，更新发放信息@tr
	public void saveCheckCloth() {
		Record[] records = (Record[]) getParameter("records");
		samGeroApplyDomain.saveCheckCloth(records);
	}
	// 确认名册时，更新发放状态@tr
	public void confirmPocket(){
		String gerocomiumId = (String) getParameter("gerocomiumId");
		String pocketYm = (String) getParameter("pocketYm");
		String pocketStatus = (String) getParameter("pocketStatus");
		samPocketApplyDomain.confirmPocket(gerocomiumId,pocketYm,pocketStatus);
	}
	// 确认名册时，更新发放状态@tr
	public void confirmCloth(){
		String gerocomiumId = (String) getParameter("gerocomiumId");
		String clothDate = (String) getParameter("clothDate");
		String clothStatus = (String) getParameter("clothStatus");
		samPocketApplyDomain.confirmCloth(gerocomiumId,clothDate,clothStatus);
	}
	// 删除名册@tr
	public void deletePocket(){
		String gerocomiumId = (String) getParameter("gerocomiumId");
		String pocketYm = (String) getParameter("pocketYm");
		String pocketStatus = (String) getParameter("pocketStatus");
		samPocketApplyDomain.deletePocket(gerocomiumId,pocketYm,pocketStatus);
	}
	// 删除名册@tr
	public void deleteCloth(){
		String gerocomiumId = (String) getParameter("gerocomiumId");
		String clothDate = (String) getParameter("clothDate");
		String clothStatus = (String) getParameter("clothStatus");
		samPocketApplyDomain.deleteCloth(gerocomiumId,clothDate,clothStatus);
	}
}