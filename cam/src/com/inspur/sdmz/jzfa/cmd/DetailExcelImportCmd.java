package com.inspur.sdmz.jzfa.cmd;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.loushang.next.core.BusinessException;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.comm.util.IdHelp;
import com.inspur.sdmz.jzfa.dao.jdbc.PlanDao;
import com.inspur.sdmz.jzfa.dao.jdbc.DetailDao;
import com.inspur.sdmz.jzfa.data.Detail;
import com.inspur.sdmz.jzfa.data.DetailModel;
import com.inspur.sdmz.jzfa.domain.IPlanDomain;

/**
 * 导入救助方案明细Excel的Cmd类
 * @author fujw  2011-5-11 下午06:01:00
 */
public class DetailExcelImportCmd extends BaseAjaxCommand {
	
	IPlanDomain planDomain = ScaComponentFactory.getService(IPlanDomain.class, "HelpDomain/HelpService");
	
	/**
	 * 导入救助方案明细Excel
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	@Trans
	public void importJzfamxExcel() throws FileNotFoundException, IOException {
		Record rec = (Record)getParameter("upLoadViewRecord");//取得前台传来的Record对象
		DetailModel jzfamxModel = (DetailModel)rec.toBean(DetailModel.class);
		String jzfaid = (String)getParameter("planId");//取得救助方案id
		UploadFile uploadFile = jzfamxModel.getUploadFile();//取得上传文件
		if(uploadFile == null) {
			throw new BusinessException("无法取得上传文件！");//异常情况 无法取得上传文件
		}
		InputStream importExcel = uploadFile.getInputStream();
		processImportJzfamxExcel(jzfaid, importExcel);
	}
	
	/**
	 * 处理导入救助方案明细Excel操作
	 * @param jzfaid
	 * @param importExcel
	 */
	private void processImportJzfamxExcel(String jzfaid, InputStream importExcel) {
		
		List<Detail> jzfamxList = new ArrayList<Detail>();		
		DetailDao detailDao = (DetailDao)DaoFactory.getDao("com.inspur.sdmz.jzfa.dao.jdbc.DetailDao");//救助方案明细Dao
		PlanDao planDao = (PlanDao)DaoFactory.getDao("com.inspur.sdmz.jzfa.dao.jdbc.PlanDao");//救助方案Dao
		
		try {
			Workbook wb = Workbook.getWorkbook(importExcel);
			Sheet sheet = wb.getSheet(0);
			
			for(int i=3; i<sheet.getRows(); i++) {
				Detail jzfamx = new Detail();
				jzfamx.setPlanId(jzfaid);//救助方案id			
				jzfamx.setDetailId(IdHelp.getUUID30());//救助方案明细id				

				jzfamx.setAssistedName(sheet.getCell(0, i).getContents().trim());//受助对象名称
				//受助对象类型
				Cell szdxlxdmCell = sheet.getCell(3, i);
				if("个人".equals(szdxlxdmCell.getContents())) {
					jzfamx.setAssistedType("0");
				}else if("家庭".equals(szdxlxdmCell.getContents())) {
					jzfamx.setAssistedType("1");
				}else if("单位".equals(szdxlxdmCell.getContents())) {
					jzfamx.setAssistedType("2");
				}else {//此字段填写其他信息时受助对象类型不正确
					throw new BusinessException("受助对象类型不正确，其值应该为'个人'、'家庭'或'单位'之一！受助对象："+jzfamx.getAssistedName()+"。");
				}				
				
				String sfzh = sheet.getCell(1, i).getContents().trim();//受助对象身份证号
				jzfamx.setIdCard(sfzh);//设置受助对象身份证号				
				String szdxId = planDomain.getCheckedJtidBysfzh(sfzh);//受助对象ID
//				if(szdxId == null || "".equals(szdxId)) {
//					throw new BusinessException("不符合救助条件的受助对象，请检查受助对象是否已审核通过！受助对象："+jzfamx.getAssistedName()+"。");
//				}else {
//					jzfamx.setAssistedId(szdxId);//设置受助对象ID
//				}
				if(szdxId != null && !"".equals(szdxId)){
					jzfamx.setAssistedId(szdxId);//设置受助对象ID
				}
				
				Cell jzfxCell = sheet.getCell(2, i);//救助方向
				if("医疗".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("YL");
				}else if("住房".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("ZF");
				}else if("事故".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("SG");
				}else if("教育".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("JY");
				}else if("养老".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("LR");
				}else if("自然灾害".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("ZH");
				}else if("残疾".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("CJ");
				}else if("失业".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("SY");
				}else if("单亲".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("DQ");
				}else if("其他".equals(jzfxCell.getContents())) {
					jzfamx.setAssistedSide("QT");
				} else {
					throw new BusinessException("救助方向不正确，其值应该为'住房'、'事故'、'教育'、'养老'、'自然灾害'、'残疾'、'失业'、'单亲'或'其他'之一！受助对象："+jzfamx.getAssistedName()+"。");
				}
				
				//处理日期单元格
				Cell jzrqCell = sheet.getCell(4, i);
				if(jzrqCell.getType() == CellType.DATE) {
					DateCell dateCell = (DateCell)jzrqCell;
					Date date = dateCell.getDate();
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					String jzrqDate = df.format(date);
					jzfamx.setAssitanceDate(jzrqDate);//救助日期
				}else if(jzrqCell.getType() == CellType.LABEL) {
					jzfamx.setAssitanceDate(jzrqCell.getContents());//救助日期
				}else {
					throw new BusinessException("受助日期格式不正确！应为：yyyy-MM-dd。受助对象："+jzfamx.getAssistedName()+"。");//异常情况 受助日期格式不正确
				}				
				
				jzfamx.setGoodsName(sheet.getCell(6, i).getContents());//救助物品名称	
				
				try{
					jzfamx.setCaptial(new BigDecimal(sheet.getCell(5, i).getContents()));//救助资金现金金额
					
					jzfamx.setGoodsNum(new BigDecimal(sheet.getCell(7, i).getContents()));//救助物品数量
					jzfamx.setGoodsNums(new BigDecimal(sheet.getCell(8, i).getContents()));//救助物品折价金额
					jzfamx.setTotalFund(new BigDecimal(sheet.getCell(9, i).getContents()));//救助资金合计金额
				}catch(Exception e) {
					e.printStackTrace();
					throw new BusinessException("救助资金现金金额、救助物品数量、救助物品折价金额或救助资金合计金额存在不正确的格式！受助对象："+jzfamx.getAssistedName()+"。");//异常情况 数值类型的格式不正确
				}
				
				jzfamxList.add(jzfamx);//将救助方案明细信息添加到List								
				
			}
			
			try{
				//执行保存
				detailDao.batchInsert(jzfamxList);//保存救助方案明细信息List
			}catch(Exception e) {
				e.printStackTrace();
				throw new BusinessException("导入失败，可能是数据库错误！");
			}
			
			for(int i=0; i<jzfamxList.size(); i++) {
				Detail jzfamx = jzfamxList.get(i);
				planDao.addJzje(jzfamx, jzfaid);//更新主表中的救助资金金额、救助户数、救助人数等
			}
			
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
