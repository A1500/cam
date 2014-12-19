package com.inspur.cams.prs.prsretiredsoldiers.cmd;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.core.BusinessException;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.dicm.IDicDao;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious;
import com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers;
import com.inspur.cams.prs.prsretiredsoldiers.domain.IPrsRetiredSoldiersDomain;
import com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy;

/**
 * 导入救助方案明细Excel的Cmd类
 * @author fujw  2011-5-11 下午06:01:00
 */
public class DetailExcelImportCmd extends BaseAjaxCommand {
	
	private IPrsRetiredSoldiersDomain prsRetiredSoldiersDomain = ScaComponentFactory
	.getService(IPrsRetiredSoldiersDomain.class,
			"PrsRetiredSoldiersDomain.PrsRetiredSoldiersService");
	
	/**
	 * 导入救助方案明细Excel
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	@Trans
	public void importSoldierExcel() throws FileNotFoundException, IOException {
		Record rec = (Record)getParameter("upLoadViewRecord");//取得前台传来的Record对象
		PrsRetiredSoldiers sodierModel = (PrsRetiredSoldiers)rec.toBean(PrsRetiredSoldiers.class);
		UploadFile uploadFile = sodierModel.getUploadFile();//取得上传文件
		if(uploadFile == null) {
			throw new BusinessException("无法取得上传文件！");//异常情况 无法取得上传文件
		}
		InputStream importExcel = uploadFile.getInputStream();
		processImportSoldierExcel(importExcel);
	}
	
	/**
	 * 处理导入救助方案明细Excel操作
	 * @param jzfaid
	 * @param importExcel
	 */
	private void processImportSoldierExcel(InputStream importExcel) {
		
		int y;
		int count = 0;
		Calendar cal=Calendar.getInstance();

		y=cal.get(Calendar.YEAR)-1;

		
		try {
			Workbook wb = Workbook.getWorkbook(importExcel);
			Sheet sheet = wb.getSheet(0);
			
			for(int i=1; i<sheet.getRows(); i++) {
				PrsRetiredSoldiers soldier = new PrsRetiredSoldiers();
				soldier.setSoldiersId(IdHelp.getUUID32());		
				count ++;
				soldier.setName(sheet.getCell(0, i).getContents().trim());//姓名
				soldier.setSpecialty(sheet.getCell(1, i).getContents().trim());//专业特长
				soldier.setServedArmy(sheet.getCell(2, i).getContents().trim());//部队单位
				//处理日期单元格
				Cell rqCell = sheet.getCell(3, i);
				if(rqCell.getType() == CellType.DATE) {
					DateCell dateCell = (DateCell)rqCell;
					Date date = dateCell.getDate();
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					String rqDate = df.format(date);
					soldier.setEnlistTime(rqDate);//入伍日期
				}else if(rqCell.getType() == CellType.LABEL) {
					soldier.setEnlistTime(rqCell.getContents());//救助日期
				}else {
					throw new BusinessException("入伍日期格式不正确！应为：yyyy-MM-dd。士兵姓名："+soldier.getName()+"。");//异常情况 入伍日期格式不正确
				}	//入伍时间	
				soldier.setEnlistPlace(sheet.getCell(4, i).getContents().trim());//入伍户口所在地
				soldier.setSpouseLocation(sheet.getCell(5, i).getContents().trim());//配偶户口所在地
				soldier.setWherePlacemen(getDicCityID(sheet.getCell(6, i).getContents().trim()));//安置地
				
				soldier.setServedMilitaryRegion(getMilitaryRegion(sheet.getCell(7, i).getContents().trim()));//档案来源（军区）

				Cell lyCell = sheet.getCell(8, i);
				if("期满原籍".equals(lyCell.getContents())) {
					soldier.setPlacemenRenson("1");
				}else if("期满易地".equals(lyCell.getContents())) {
					soldier.setPlacemenRenson("2");
				}else if("提前原籍".equals(lyCell.getContents())) {
					soldier.setPlacemenRenson("3");
				}else if("提前易地".equals(lyCell.getContents())) {
					soldier.setPlacemenRenson("4");
				}else {//安置理由输入有误
					throw new BusinessException("安置理由输入不正确，其值应该为'期满原籍'、'期满易地'、'提前原籍'或'提前易地'之一！士兵姓名："+soldier.getName()+"。");
				}	//安置理由			
				soldier.setTransFile(sheet.getCell(9, i).getContents().trim());//移交材料
				soldier.setFlag("1");//是否退档	
				soldier.setContent(sheet.getCell(10, i).getContents().trim());//备注
				//设置默认值
				soldier.setRetiredSoldierType("3");
		    	  soldier.setAllotFlag("0");
		    	  soldier.setEmplacementflag("0");
		    	  soldier.setTrainingflag("0");
		    	  soldier.setFlag("1");
		    	  soldier.setUploadFlag("1");
		    	  soldier.setDisabilityFlag("0");
		    	  soldier.setSex("1");
		    	  soldier.setNaton("01");
		    	  soldier.setRetiredTime(y+"-12-01");
		    	  soldier.setFileNum(MaxValueUtil.nextStringValue("RETIRED_SOLDIER_FILE_NUM"));
		    	  PrsSoldiersArmy army = new PrsSoldiersArmy();
					army.setArmyId(IdHelp.getUUID32());
					army.setSoldiersId(soldier.getSoldiersId());
					List<PrsAwardsMeritorious> awards = new ArrayList<PrsAwardsMeritorious>();
					prsRetiredSoldiersDomain.saveBaseInfo(soldier, army, awards);
			}
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		setReturn("count",count);
	}
	@Trans
	private String getDicCityID(Object xian) {
		if(xian==null) return null;
		ParameterSet pset = new ParameterSet();
		DicCityDao dao = (DicCityDao) DaoFactory
		.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		String name =xian.toString().trim();
		if("".equals(name))return null;
		pset.setParameter("FULL_NAME", name);
		DataSet dataSet = dao.query(pset);
		if(dataSet.getCount()>0){
			return (String) dataSet.getRecord(0).get("id");
		}
		return null;
	}
	
	private String getMilitaryRegion(Object object) {
		if(object==null) return null;
		ParameterSet pset = new ParameterSet();
		pset.setParameter("dic","DIC_MILITARY_REGION_CODE");
		pset.setParameter("value", "CODE");
		pset.setParameter("text", "NAME");
		String filterSql = " NAME = '" +object.toString().trim()+"' ";
		pset.setParameter("filterSql", filterSql);
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		DataSet ds = dao.getDicMapList(pset);
		if(ds.getCount()>0){
			String re = (String) ds.getRecord(0).get("value"); 
			return re;
		}
		return null;
	}
}
