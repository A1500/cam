package com.inspur.cams.drel.samu.domain;

import java.math.BigDecimal;

import org.loushang.sca.transaction.Trans;

/**
 * 零花钱发放domain
 * @author 
 * @date 2012-11-01
 */
public interface ISamPocketApplyDomain {
	// 零花钱 生成名册时，保存名册
	@Trans
	public void insertSave(String gerocomiumName, String pocketYm,
			BigDecimal pocketMoney);
	// 服装 生成名册时，保存名册
	@Trans
	public void insertSaveCloth(String gerocomiumName, String clothDate,String clothType,
			BigDecimal clothNum);
	// 零花钱确认名册时，更新发放状态
	@Trans
	public void confirmPocket(String gerocomiumId,String pocketYm,String pocketStatus);
	// 服装确认名册时，更新发放状态
	@Trans
	public void confirmCloth(String gerocomiumId,String pocketDate,String clothStatus);
	// 零花钱删除名册
	@Trans
	public void deletePocket(String gerocomiumId,String pocketYm,String pocketStatus);
	// 零花钱删除名册
	@Trans
	public void deleteCloth(String gerocomiumId,String pocketDate,String clothStatus);
}
